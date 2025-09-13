import 'package:flutter/material.dart';
import 'package:leaf_it/Details/DetailsPage.dart';
import 'package:leaf_it/MainTheme.dart';
import 'package:leaf_it/Theme/CurvedAppbar.dart';
import 'package:leaf_it/api/api_manager.dart';
import 'package:leaf_it/model/FieldsResponse.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class AnalyticsTab extends StatefulWidget {
  static const String routeName = "Analytics";

  @override
  State<AnalyticsTab> createState() => _AnalyticsTabState();
}

class _AnalyticsTabState extends State<AnalyticsTab> {
  late Future<FieldsResponse?> _fieldsFuture;

  @override
  void initState() {
    super.initState();
    _fetchFeeds();
  }

  void _fetchFeeds() {
    setState(() {
      _fieldsFuture = ApiManager.getFields();
    });
  }

  Future<void> triggerServoDig() async {
    final uri = Uri.parse("http://172.20.10.9:80/dig"); // Your ESP32 IP
    try {
      final response = await http.post(uri);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Servo activated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(title: AppLocalizations.of(context)!.analytics),
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchFeeds();
        },
        child: FutureBuilder<FieldsResponse?>(
          future: _fieldsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: MainTheme.LightGreen,
                ),
              );
            } else if (snapshot.hasError) {
              debugPrint('Error: ${snapshot.error}');
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Something went wrong',
                        style: TextStyle(
                            color: MainTheme.LightGreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                    SizedBox(height: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                          WidgetStatePropertyAll(Size(150, 50))),
                      onPressed: _fetchFeeds,
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            var feedsList = snapshot.data?.feeds ?? [];
            if (feedsList.isEmpty) {
              return Center(child: Text('No data available'));
            }

            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: feedsList.length,
              itemBuilder: (context, index) {
                var humidity = feedsList[index].field1 ?? "N/A";
                var temperature = feedsList[index].field2?.trim() ?? "N/A";
                var moisture = feedsList[index].field3 ?? "N/A";
                var raindrop = feedsList[index].field4 ?? "N/A";

                double moistureValue = double.tryParse(moisture) ?? 0;
                double humidityValue = double.tryParse(humidity) ?? 0;
                double tempValue = double.tryParse(temperature) ?? 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTemperatureCard(context,
                        AppLocalizations.of(context)!.temperature, Icons.thermostat, tempValue),
                    SizedBox(height: 10),
                    buildPieChartCard(context,
                        AppLocalizations.of(context)!.humidity, Icons.water_drop_rounded, humidityValue, MainTheme.LightGreen),
                    SizedBox(height: 10),
                    buildPieChartCard(
                        context,
                        AppLocalizations.of(context)!.moisture,
                        Icons.water_outlined,
                        (1 - (moistureValue / 1023)) * 100,
                        MainTheme.LightGreen),
                    SizedBox(height: 10),

                    // 👇 Servo control button here
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: triggerServoDig,
                        icon: Icon(Icons.construction),
                        label: Text("Dig Soil Sensor"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainTheme.LightGreen,
                          foregroundColor: MainTheme.blueMain,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    buildRainCard(context,
                        AppLocalizations.of(context)!.raindrop, Icons.cloudy_snowing, raindrop.trim() == "0" ? 'Yes' : 'No'),
                    SizedBox(height: 20),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildPieChartCard(BuildContext context, String label, IconData icon,
      double percentage, Color color) {
    return Animate(
      effects: [FadeEffect(duration: 400.ms), ScaleEffect(duration: 400.ms)],
      child: Container(
        decoration: BoxDecoration(
          color: MainTheme.darkBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 8),
                Text('${percentage.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            SizedBox(
              height: 100,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 20,
                  sections: [
                    PieChartSectionData(
                      value: percentage,
                      color: color,
                      radius: 30,
                      title: '',
                    ),
                    PieChartSectionData(
                      value: 100 - percentage,
                      color: Colors.grey[800],
                      radius: 30,
                      title: '',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTemperatureCard(BuildContext context, String label,
      IconData icon, double tempValue) {
    double tempPercent = ((tempValue.clamp(0, 50)) / 50) * 100;

    return Animate(
      effects: [FadeEffect(duration: 400.ms), ScaleEffect(duration: 400.ms)],
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: tempValue > 32
                ? [Colors.redAccent, Colors.orange.shade200, Colors.orange.shade400]
                : [MainTheme.darkBlue, MainTheme.blueMain, Colors.orange.shade300],
            stops: [0.3, 0.6, 0.7],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: Colors.white),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: MainTheme.LightGreen)),
                    Text('${tempValue.toStringAsFixed(1)}°C',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: MainTheme.LightGreen)),
                  ],
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.ac_unit, color: Colors.white),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: LinearProgressIndicator(
                      value: tempPercent / 100,
                      minHeight: 10,
                      backgroundColor: Colors.white30,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          MainTheme.LightGreen),
                    ),
                  ),
                ),
                Icon(Icons.wb_sunny, color: Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildRainCard(BuildContext context, String label, IconData icon, String value) {
    bool isRaining = value == 'Yes';
    return Animate(
      effects: [FadeEffect(duration: 400.ms), ScaleEffect(duration: 400.ms)],
      child: Container(
        decoration: BoxDecoration(
          color: isRaining ? Colors.blueGrey[700] : MainTheme.darkBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isRaining ? Icons.cloudy_snowing : Icons.wb_sunny,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: MainTheme.LightGreen)),
                Text(value,
                    style: TextStyle(color: MainTheme.LightGreen, fontSize: 20)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
