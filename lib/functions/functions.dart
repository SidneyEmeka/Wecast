import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wecast/utilities/utility.dart';

//variables
String cityName = "Nigeria";
//fn to call weather api
Future<Map<String, dynamic>> getWeather() async {
  try {
    var response = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$key"),
    );

    final data = jsonDecode(response.body);

    if (data["cod"] != "200") {
      throw "Unable to fetch data";
    }

    return data;
  } catch (e) {
    throw e.toString();
  }
}

//fn to conovert Kelvin to Celcuis
String convertTemp(double value) {
  double cent = value - 273.15;
  return cent.toStringAsFixed(0);
}
