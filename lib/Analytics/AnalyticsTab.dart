import 'package:flutter/material.dart';
import 'package:leaf_it/MainTheme.dart';
import 'package:leaf_it/api/api_manager.dart';
import 'package:leaf_it/model/FeedsResponse.dart';
import 'package:leaf_it/model/FieldsResponse.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 22.0),
          child: Center(
            child: Text(
              "Analytics",
              style: Theme.of(context).textTheme.titleLarge,
            )
                .animate()
                .fadeIn(
                    delay: Duration(milliseconds: 500),
                    duration: Duration(milliseconds: 500))
                .slideX(
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 500)),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: FutureBuilder<FieldsResponse?>(
        future: _fieldsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            debugPrint('Error: ${snapshot.error}');
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Something went wrong'),
                  SizedBox(height: 8),
                  ElevatedButton(
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

          // Display both temperature and humidity
          return ListView.builder(padding: EdgeInsets.all(10),
            itemCount: feedsList.length,
            itemBuilder: (context, index) {
              var humidity = feedsList[index].field1 ?? "N/A";
              var temperature = feedsList[index].field2?.trim() ?? "N/A";

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: MainTheme.darkBlue,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Temperature",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                Icon(Icons.thermostat, color: Colors.white),
                                SizedBox(
                                    width:
                                        8), // Adds space between the icon and text
                                Text(
                                  '$temperature°C',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 16.0), // Adds space between containers
                        decoration: BoxDecoration(
                          color: MainTheme.darkBlue,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Humidity",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                Icon(Icons.water_drop_rounded,
                                    color: Colors.white),
                                SizedBox(
                                    width:
                                        8), // Adds space between the icon and text
                                Text(
                                  '$humidity%',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
