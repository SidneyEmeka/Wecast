import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wecast/utilities/utility.dart';

Future getWeather() async {
  try {
    String cityName = "Nigeria";
    var response = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$key"),
    );
    
    final data = jsonDecode(response.body);

    if(data["cod"] != "200") {
      throw "Unable to fetch data";
    }
     final temp = (data["list"][0]["main"]["temp"]);
  } catch(e) {
    throw e.toString();
  }
}
