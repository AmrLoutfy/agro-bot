import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:leaf_it/MainTheme.dart';
import 'package:leaf_it/Theme/CurvedAppbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DetailsPage extends StatelessWidget {
  final String label;
  final String value;
  final double percentage;

  const DetailsPage({Key? key, required this.label, required this.value,required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/lightback3.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          appBar: CurvedAppBar(title: label),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                SizedBox(
                  height: 100,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 30,
                      sections: [
                        PieChartSectionData(
                          value: percentage,
                          color: MainTheme.LightGreen,
                          radius: 50,
                          title: '',
                          titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        PieChartSectionData(
                          value: 100 - percentage,
                          color: Colors.grey[800],
                          radius: 50,
                          title: '',
                        ),
                      ],
                    ),
                  ),
                ),SizedBox(height: 30,),Center(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
