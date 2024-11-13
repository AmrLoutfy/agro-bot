import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leaf_it/api/api_constants.dart';
import 'package:leaf_it/model/FeedsResponse.dart';
import 'package:leaf_it/model/FieldsResponse.dart';


class ApiManager {
  static Future<FieldsResponse?> getFields() async {
    Uri url = Uri.https(ApiConst.baseUrl, ApiConst.fieldsApi, {
      'api_key': 'KBYMM43FKCH36JEN',
      'results': '1'
    });
    try {
      var response = await http.get(url);
      print('API Response Status: ${response.statusCode}'); // Log status code
      print('API Response Body: ${response.body}'); // Log response body

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return FieldsResponse.fromJson(json);
      } else {
        print('Error: ${response.reasonPhrase}');
        return null; // or handle the error as necessary
      }
    } catch (e) {
      print('Error fetching feeds: $e'); // Log error
      throw e;
    }
  }




}


  /*static Future<HumidityResponse?> getHumidity() async {
/*https://api.thingspeak.com/channels/2718757/fields/2.json?api_key=KBYMM43FKCH36JEN&results=1*/

    Uri url = Uri.https(ApiConst.baseUrl, ApiConst.humApi,
        {'apikey': 'KBYMM43FKCH36JEN', 'results': '1'});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return HumidityResponse.fromJson(json);
    } catch (a) {
      throw a;
    }
  }*/

