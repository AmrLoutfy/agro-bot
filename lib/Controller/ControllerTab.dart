import 'package:flutter/material.dart';
import 'package:leaf_it/MainTheme.dart';
import 'package:leaf_it/Theme/CurvedAppbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ControllerTab extends StatefulWidget {
  static const String routeName = "ControllerTab";

  @override
  State<ControllerTab> createState() => _ControllerTabState();
}

class _ControllerTabState extends State<ControllerTab> {
  WebViewController? _webViewController;
  final String baseStreamUrl = "http://172.20.10.8:8000"; // Raspberry Pi stream IP
  final String esp32Ip = "http://172.20.10.9:80";     // ESP32 control IP

  bool isHolding = false;
  bool isCameraMode = false;
  bool streamAvailable = true;
  String? currentPressedDirection;

  @override
  void initState() {
    super.initState();
    initWebView();

  }

  void initWebView() {
    final streamUrl = isCameraMode
        ? "$baseStreamUrl/stream?cam=1"
        : "$baseStreamUrl/stream?cam=0";

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            setState(() => streamAvailable = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(streamUrl));
  }

  Future<void> sendCommand(String direction) async {
    try {
      final response = await http.post(
        Uri.parse('$esp32Ip/move'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'direction': direction}),
      );
      print('sendCommand: $direction - status: ${response.statusCode}');
    } catch (e) {
      print('Error sending command: $e');
    }
  }

  Future<void> sendServo(String direction) async {
    try {
      final response = await http.post(
        Uri.parse('$esp32Ip/servo'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'servo': direction}),
      );
      print('sendServo: $direction - status: ${response.statusCode}');
    } catch (e) {
      print('Error sending servo command: $e');
    }
  }

  void sendLoop(String direction) {
    Future.doWhile(() async {
      if (!isHolding) return false;
      isCameraMode
          ? await sendServo(direction)
          : await sendCommand(direction);
      await Future.delayed(Duration(milliseconds: 200));
      return true;
    });
  }

  Widget buildHoldButton({
    required IconData icon,
    required String direction,
    Color color = Colors.green,
  }) {
    final isPressed = currentPressedDirection == direction;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isHolding = true;
          currentPressedDirection = direction;
        });
        sendLoop(direction);
      },
      onTapUp: (_) {
        setState(() {
          isHolding = false;
          currentPressedDirection = null;
        });
        if (!isCameraMode) sendCommand("stop");
      },
      onTapCancel: () {
        setState(() {
          isHolding = false;
          currentPressedDirection = null;
        });
        if (!isCameraMode) sendCommand("stop");
      },
      child: ElevatedButton(
        onPressed: () {}, // IMPORTANT: enable the button
        style: ElevatedButton.styleFrom(
          backgroundColor: isPressed ? Colors.orange : color,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        ),
        child: Icon(icon, color: MainTheme.blueMain),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(title: AppLocalizations.of(context)!.controls),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              child: streamAvailable && _webViewController != null
                  ? WebViewWidget(controller: _webViewController!)
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 40),
                  SizedBox(height: 10),
                  Text("Stream unavailable", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        streamAvailable = true;
                        initWebView();
                      });
                    },
                    child: Text("Try Again"),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCameraMode = !isCameraMode;
                  streamAvailable = true;
                  initWebView();
                });
              },
              child: Text(
                isCameraMode
                    ? AppLocalizations.of(context)!.switchnav
                    : AppLocalizations.of(context)!.switchdis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    isCameraMode
                        ? AppLocalizations.of(context)!.disease
                        : AppLocalizations.of(context)!.movement,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MainTheme.LightGreen,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildHoldButton(
                        icon: isCameraMode ? Icons.keyboard_arrow_up : Icons.arrow_upward,
                        direction: "up",
                        color: MainTheme.LightGreen,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildHoldButton(
                        icon: isCameraMode ? Icons.keyboard_arrow_left : Icons.arrow_back,
                        direction: "left",
                        color: MainTheme.LightGreen,
                      ),
                      if (!isCameraMode)
                        ElevatedButton(
                          onPressed: () => sendCommand("stop"),
                          child: Icon(Icons.stop, color: MainTheme.blueMain),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          ),
                        ),
                      buildHoldButton(
                        icon: isCameraMode ? Icons.keyboard_arrow_right : Icons.arrow_forward,
                        direction: "right",
                        color: MainTheme.LightGreen,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildHoldButton(
                        icon: isCameraMode ? Icons.keyboard_arrow_down : Icons.arrow_downward,
                        direction: "down",
                        color: MainTheme.LightGreen,
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
  }
}
