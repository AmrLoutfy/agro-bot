import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendCommand(String direction) async {
  final response = await http.post(
    Uri.parse('http://<raspberry_pi_ip>:5000/move'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'direction': direction}),
  );
  if (response.statusCode == 200) {
    print('Command sent successfully');
  } else {
    print('Failed to send command');
  }
}
