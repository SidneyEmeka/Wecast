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
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 76, 0, 51),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              theWeather = getWeather("Nigeria");
            });
          },
          child: const Icon(
            Icons.cloudy_snowing,
            color: Colors.white,
            size: 15,
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  theWeather = getWeather("Nigeria");
                });
              },
              child: Text(
                "WECAST",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],

        //centerTitle:true,
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
            return DateFormat.jm().format(time);
          }

          num fval(int index) {
            return data["list"][index]["main"]["temp"];
          }

          String ficon(int index) {
            final fIcon =
                "https://openweathermap.org/img/w/${data["list"][index]["weather"][0]["icon"]}.png";
            return fIcon;
          }

          String fdescribe(int index) {
            return data["list"][index]["weather"][0]["main"];
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Verticalspace(value: 40),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Color.fromARGB(255, 76, 0, 51))),
                    padding: EdgeInsets.only(left: 15, bottom: 4),
                    width: w / 2,
                    height: 30,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            enableSuggestions: true,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            controller: citySearchController,
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              hintText: "Enter City",
                              hintStyle: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  theWeather = getWeather(
                                      citySearchController.text.isEmpty
                                          ? "Nigeria"
                                          : citySearchController.text.trim());
                                });
                              },
                              icon: Icon(
                                Icons.send_sharp,
                                size: 15,
                                color: Color.fromARGB(255, 76, 0, 51),
                              ),
                            ))
                      ],
                    ),
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
                          Text(
                            "${data["city"]["name"].toString().toUpperCase()} - ${data["city"]["country"]}",
                            style: TextStyle(
                                color: Color.fromARGB(255, 76, 0, 51)),
                          ),
                          Text(
                            "${convertTemp(currentTemp)}°C",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 76, 0, 51),
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
                              color: Color.fromARGB(255, 76, 0, 51),
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
                        color: Color.fromARGB(255, 76, 0, 51)),
                  ),
                  const Verticalspace(value: 5),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ForecastCards(
                          time: ftime(1),
                          temp: "${convertTemp(fval(1))}°C",
                          iconImage: Image.network(
                            ficon(1),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                          describe: fdescribe(1),
                        ),
                        Horizontalspace(value: 5),
                        ForecastCards(
                          time: ftime(2),
                          temp: "${convertTemp(fval(2))}°C",
                          iconImage: Image.network(
                            ficon(2),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                          describe: fdescribe(2),
                        ),
                        Horizontalspace(value: 5),
                        ForecastCards(
                          time: ftime(3),
                          temp: "${convertTemp(fval(3))}°C",
                          iconImage: Image.network(
                            ficon(3),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                          describe: fdescribe(3),
                        ),
                        Horizontalspace(value: 5),
                        ForecastCards(
                          time: ftime(4),
                          temp: "${convertTemp(fval(4))}°C",
                          iconImage: Image.network(
                            ficon(4),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                          describe: fdescribe(4),
                        ),
                        Horizontalspace(value: 5),
                        ForecastCards(
                          time: ftime(5),
                          temp: "${convertTemp(fval(5))}°C",
                          iconImage: Image.network(
                            ficon(5),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                          describe: fdescribe(5),
                        ),
                        Horizontalspace(value: 5),
                        ForecastCards(
                          time: ftime(6),
                          temp: "${convertTemp(fval(6))}°C",
                          iconImage: Image.network(
                            ficon(6),
                            width: 40,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                          describe: fdescribe(6),
                        ),
                      ],
                    ),
                  ),

                  const Verticalspace(value: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InfoCards(
                          icon: const Icon(
                            Icons.water_drop,
                            color: Color.fromARGB(255, 76, 0, 51),
                          ),
                          text: const Text(
                            "Humidity",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 76, 0, 51)),
                          ),
                          value: Text(
                            humidity.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 76, 0, 51)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InfoCards(
                          icon: const Icon(Icons.wind_power_outlined,
                              color: Color.fromARGB(255, 76, 0, 51)),
                          text: const Text(
                            "Wind Speed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 76, 0, 51)),
                          ),
                          value: Text(
                            windSpeed.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 76, 0, 51)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InfoCards(
                          icon: const Icon(Icons.beach_access,
                              color: Color.fromARGB(255, 76, 0, 51)),
                          text: const Text(
                            "Pressure",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 76, 0, 51)),
                          ),
                          value: Text(
                            pressure.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color.fromARGB(255, 76, 0, 51)),
                          ),
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
