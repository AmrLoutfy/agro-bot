import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leaf_it/Analytics/AnalyticsTab.dart';
import 'package:leaf_it/Controller/ControllerTab.dart';
import 'package:leaf_it/MainTheme.dart';
import 'package:leaf_it/Settings/Settings.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedInd = 0;

  final List<Widget> tabs = [
    AnalyticsTab(),
    ControllerTab(),
    SettingsTab(),
  ];

  // Helper to keep currentIndex in valid range for BottomNavigationBar
  int getNavBarIndex() {
    if (selectedInd == 0) return 0;
    if (selectedInd == 2) return 1;
    return 0; // fallback if controller is selected
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          'assets/images/lightback3.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: tabs[selectedInd],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: MainTheme.LightSec),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 50,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: (value) {
                    // 0 = Analytics, 1 = Settings
                    selectedInd = value == 0 ? 0 : 2;
                    setState(() {});
                  },
                  currentIndex: getNavBarIndex(),
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
                        icon: Icons.settings,
                        isSelected: selectedInd == 2,
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Middle semicircle controller icon
        Positioned(
          bottom: 35,
          child: GestureDetector(
            onTap: () {
              selectedInd = 1;
              setState(() {});
            },
            child: Animate(
              key: ValueKey(selectedInd == 1),
              effects: selectedInd == 1
                  ? [ShakeEffect(hz: 9, duration: 300.ms)]
                  : [],
              child: Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(border: Border.all(
                  color: selectedInd == 1
                      ? MainTheme.LightGreen // border when selected
                      : MainTheme.blueMain,                   // border when not selected
                  width: 3.0,
                ),
                  shape: BoxShape.circle,
                  color: selectedInd == 1
                      ? MainTheme.LightSec // highlighted
                      : MainTheme.blueMain, // normal
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable icon widget with optional shake effect
Widget _buildIcon({required IconData icon, required bool isSelected}) {
  return Animate(
    key: ValueKey(isSelected),
    effects: isSelected ? [ShakeEffect(hz: 9, duration: 300.ms)] : [],
    child: Icon(
      icon,
      size: 25,
      color: isSelected ? MainTheme.LightGreen : Colors.grey,
    ),
  );
}
