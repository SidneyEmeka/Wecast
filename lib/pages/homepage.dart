import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../utilities/utility.dart';
import '../widgets/forecast_cards.dart';
import '../widgets/info_cards.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<Map<String, dynamic>> getWeather() async {
    try {
      String cityName = "Nigeria";
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
        leading: const Icon(
          Icons.cloudy_snowing,
          color: Colors.white,
        ),
        title: const Text(
          "WECAST",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_outlined),
            iconSize: 27,
            color: Colors.white,
          )
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                              ? Icons.cloudy_snowing
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
                verticalSpace(30),

                //forecast cards
                const Text(
                  "Forecasts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(15),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ForecastCards(),
                      ForecastCards(),
                      ForecastCards(),
                      ForecastCards(),
                      ForecastCards(),
                    ],
                  ),
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
                verticalSpace(15),
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
          );
        },
      ),
    );
  }
}
