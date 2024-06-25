import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../functions/functions.dart';
import '../widgets/forecast_cards.dart';
import '../widgets/info_cards.dart';
import '../widgets/spacing.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Map<String, dynamic>> theWeather;
  final TextEditingController citySearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    theWeather = getWeather("Nigeria");
  }

  @override
  Widget build(BuildContext context) {
    //Reusables
    double w = MediaQuery.of(context).size.width;
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 0, 51),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // leading: const Icon(
        //   Icons.cloudy_snowing,
        //   color: Colors.white,
        //   size: 15,
        // ),
        title: const Text(
          "WECAST",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        // centerTitle:true,
        // actions: [
        //   Container(
        //     width: 150,
        //     height: 30,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.transparent,
        //       border: Border.all(
        //         color: Colors.white,
        //       ),
        //     ),
        //     child: TextField(
        //       cursorColor: Colors.white,
        //       controller: citySearchController,
        //       style: const TextStyle(
        //         color: Color.fromARGB(255, 76, 0, 51),
        //       ),
        //       decoration: InputDecoration(
        //         hintStyle: const TextStyle(
        //           color: Color.fromARGB(255, 76, 0, 51),
        //           fontSize: 10,
        //         ),
        //         hintText: "Search City",
        //         focusedBorder: border,
        //         enabledBorder: border,
        //         filled: true,
        //         fillColor: Colors.white,
        //       ),
        //       keyboardType: TextInputType.text,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       setState(() {
        //         cityName = citySearchController.text;
        //       });
        //     },
        //     icon: const Icon(Icons.cloud_sync),
        //     color: Colors.white,
        //     iconSize: 20,
        //   ),
        // ],
      ),
      body: FutureBuilder(
        future: theWeather,
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
          final currentDescription =
              currentWetData["weather"][0]["description"];
          final pressure = currentWetData["main"]["pressure"];
          final windSpeed = currentWetData["wind"]["speed"];
          final humidity = currentWetData["main"]["humidity"];
          final wIcon = Uri.parse(
              "https://openweathermap.org/img/w/${currentWetData["weather"][0]["icon"]}");

          String ftime(int index) {
            final time = DateTime.parse(data["list"][index]["dt_txt"]);
            return DateFormat.j().format(time);
          }

          double fval(int index) {
            return data["list"][index]["main"]["temp"];
          }

          String ficon(int index) {
            final fIcon =
                "https://openweathermap.org/img/w/${data["list"][index]["weather"][0]["icon"]}.png";
            return fIcon;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    controller: citySearchController,
                    decoration: InputDecoration(
                        hintText: "City",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              //cityName = citySearchController.text;
                              theWeather =
                                  getWeather(citySearchController.text);
                            });
                          },
                          icon: Icon(Icons.send_rounded),
                        )),
                  ),
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
                          const Verticalspace(value: 25),
                          Text(citySearchController.text == ""
                              ? "NIGERIA"
                              : citySearchController.text.toUpperCase()),
                          Text(
                            "${convertTemp(currentTemp)}°C",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Verticalspace(value: 5),
                          Image.network(
                            "$wIcon.png",
                            width: 70,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const Verticalspace(value: 5),
                          Text(
                            textAlign: TextAlign.center,
                            "$currentSky - $currentDescription",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Verticalspace(value: 25),
                        ],
                      ),
                    ),
                  ),
                  const Verticalspace(value: 10),

                  //forecast cards
                  const Text(
                    "Forecasts",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Verticalspace(value: 5),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ForecastCards(
                          text: Text(ftime(1)),
                          value: Text("${convertTemp(fval(1))} °C"),
                          iconImage: Image.network(
                            ficon(1),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ForecastCards(
                          text: Text(ftime(2)),
                          value: Text("${convertTemp(fval(2))} °C"),
                          iconImage: Image.network(
                            ficon(2),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ForecastCards(
                          text: Text(ftime(3)),
                          value: Text("${convertTemp(fval(3))} °C"),
                          iconImage: Image.network(
                            ficon(3),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ForecastCards(
                          text: Text(ftime(4)),
                          value: Text("${convertTemp(fval(4))} °C"),
                          iconImage: Image.network(
                            ficon(4),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ForecastCards(
                          text: Text(ftime(5)),
                          value: Text("${convertTemp(fval(5))} °C"),
                          iconImage: Image.network(
                            ficon(5),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ForecastCards(
                          text: Text(ftime(6)),
                          value: Text("${convertTemp(fval(6))} °C"),
                          iconImage: Image.network(
                            ficon(6),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // SizedBox(
                  //   height: 100.0,
                  //   child: ListView.builder(
                  //     itemCount: 4,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       final foreCast = data["list"][index + 1];
                  //       final time = DateTime.parse(foreCast["dt_txt"]);
                  //       final forecastVal = foreCast["main"]["temp"];
                  //       final fIcon = Uri.parse(
                  //           "https://openweathermap.org/img/w/${foreCast["weather"][0]["icon"]}");
                  //
                  //       return ForecastCards(
                  //         text: Text(DateFormat.j().format(time)),
                  //         value: Text("${convertTemp(forecastVal)} °C"),
                  //         icon: Image.network(
                  //           "$fIcon.png",
                  //           width: 40,
                  //           height: 25,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

                  const Verticalspace(value: 10),
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
                            textAlign: TextAlign.center,
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
