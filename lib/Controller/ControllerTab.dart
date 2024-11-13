import 'package:flutter/material.dart';

class ControllerTab extends StatefulWidget {
  static const String routeName = "ControllerTab";

  @override
  State<ControllerTab> createState() => _ControllerTabState();
}

class _ControllerTabState extends State<ControllerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Spacer(),
              Text(
                "Controls",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [ Column(
            children: [Image.asset('assets/images/video.jpg'),Container(child: Image.asset('assets/images/arrows.png')),],
          ),],
        ));
  }
}
