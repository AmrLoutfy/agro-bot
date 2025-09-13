import 'package:flutter/material.dart';
import 'package:leaf_it/HomeScreen/Homescreen.dart';
import 'package:leaf_it/MainTheme.dart';
class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(

          children: [
            Image.asset("assets/images/lightback3.png"),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png',height: 200,width: 230,),
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                  CircularProgressIndicator(color: MainTheme.LightGreen,),
                ],
              ),
            ),
          ],

      ),
    );
  }
}
