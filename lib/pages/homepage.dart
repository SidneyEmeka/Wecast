import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/utility.dart';
import '../widgets/forecast_cards.dart';
import '../widgets/info_cards.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cityName = "France";

  @override
  void initState() {
    super.initState();
    getWeather();
  }

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

  final TextEditingController citySearchController = TextEditingController();
  var border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black38,
      width: 2.0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    //Reusables
    double w = MediaQuery.of(context).size.width;

    Widget verticalSpace(double value) {
      return SizedBox(
        height: value,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 0, 51),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: const Icon(
          Icons.cloudy_snowing,
          color: Colors.white,
          size: 15,
        ),
        title: const Text(
          "WECAST",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            width: 150,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            // padding: const EdgeInsets.all(10),
            child: TextField(
              controller: citySearchController,
              style: const TextStyle(
                color: Color.fromARGB(255, 76, 0, 51),
              ),
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 76, 0, 51),
                  fontSize: 10,
                ),
                hintText: "Search City",
                focusedBorder: border,
                enabledBorder: border,
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                cityName = citySearchController.text;
              });
            },
            icon: const Icon(Icons.send),
            color: Colors.white,
            iconSize: 20,
          ),
        ],
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Unable to Connect",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 76, 0, 51)),
              ),
            );
          }

          final data = snapshot.data!;
          final currentWetData = data["list"][0];
          final currentTemp = currentWetData["main"]["temp"];
          final currentSky = currentWetData["weather"][0]["main"];
          final pressure = currentWetData["main"]["pressure"];
          final windSpeed = currentWetData["wind"]["speed"];
          final humidity = currentWetData["main"]["humidity"];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //main card
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    width: w,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          verticalSpace(25),
                          Text(cityName.toUpperCase()),
                          Text(
                            "$currentTemp K",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          verticalSpace(15),
                          Icon(
                            currentSky == "Clouds" || currentSky == "Rain"
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 40,
                          ),
                          verticalSpace(15),
                          Text(
                            "$currentSky",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          verticalSpace(25),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(20),

                  //forecast cards
                  const Text(
                    "Forecasts",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        itemCount: 9,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final foreCast = data["list"][index + 1];

                          final time = DateTime.parse(foreCast["dt_txt"]);
                          return ForecastCards(
                            text: Text(DateFormat.j().format(time)),
                            value: Text(foreCast["main"]["temp"].toString()),
                            icon: foreCast["weather"][0]["main"] == "Clouds" ||
                                    foreCast["weather"][0]["main"] == "Rain"
                                ? const Icon(Icons.cloud)
                                : const Icon(Icons.sunny),
                          );
                        }),
                  ),
                  verticalSpace(30),

                  //additional infos
                  const Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InfoCards(
                          icon: const Icon(Icons.water_drop),
                          text: const Text(
                            "Humidity",
                            style: TextStyle(fontSize: 10),
                          ),
                          value: Text(humidity.toString()),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InfoCards(
                          icon: const Icon(Icons.wind_power_outlined),
                          text: const Text(
                            "Wind Speed",
                            style: TextStyle(fontSize: 10),
                          ),
                          value: Text(windSpeed.toString()),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InfoCards(
                          icon: const Icon(Icons.beach_access),
                          text: const Text(
                            "Pressure",
                            style: TextStyle(fontSize: 10),
                          ),
                          value: Text(pressure.toString()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
