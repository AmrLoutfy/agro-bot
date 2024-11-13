import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leaf_it/Analytics/AnalyticsTab.dart';
import 'package:leaf_it/Controller/ControllerTab.dart';
import 'package:leaf_it/MainTheme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedInd = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/lightback3.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
      Scaffold(
        appBar: AppBar(

        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: MainTheme.LightSec),
          child: Container(margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 50,offset: Offset(0, 4))]),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50))
              ,child: BottomNavigationBar(showSelectedLabels: false,showUnselectedLabels: false,
                onTap: (value) {
                  selectedInd = value;
                  setState(() {});
                },
                currentIndex: selectedInd,
                items: [
    BottomNavigationBarItem(
    icon: _buildIcon(
    icon: Icons.analytics_outlined,
    isSelected: selectedInd == 0,
    ),
    label: '',
    ),
    BottomNavigationBarItem(
    icon: _buildIcon(
    icon: Icons.control_camera_sharp,
    isSelected: selectedInd == 1,
    ),
    label: ''),

    ],
              ),
            ),
          ),
        ),
        body: tabs[selectedInd],
      )
    ]);
  }

  List<Widget> tabs = [AnalyticsTab(), ControllerTab()];
}
Widget _buildIcon({required IconData icon, required bool isSelected}) {
  return Animate(
    key: ValueKey(isSelected), // Forces re-build when selection changes
    effects: isSelected
        ? [ShakeEffect(hz: 9, duration: 300.ms)] // Apply shake effect if selected
        : [],
    child: Icon(icon, size: 25),
  );
}

