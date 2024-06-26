import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../functions/functions.dart';
import '../widgets/forecast_cards.dart';
import '../widgets/info_cards.dart';
import '../widgets/spacing.dart';
import '../widgets/tabbar.dart';
import 'forecastdays.dart';

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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 15,
          backgroundColor: const Color.fromARGB(255, 76, 0, 51),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          bottom: myTabs(),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: theWeather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
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
                  return data["list"][index]["weather"][0]["description"];
                }

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Verticalspace(value: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 76, 0, 51),
                            ),
                          ),
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
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  controller: citySearchController,
                                  decoration: InputDecoration(
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
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
                                                : citySearchController.text
                                                    .trim());
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
                          margin: const EdgeInsets.only(
                            top: 10,
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
                        Card(
                          color: Color.fromARGB(255, 76, 0, 51),
                          elevation: 5,
                          child: Container(
                              alignment: Alignment.center,
                              width: w - 40,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                currentSky == 'Rain' || currentSky == 'Clouds'
                                    ? "RECOMMENDATION - FOR NOW, USE AN UMBRELLA"
                                    : "RECOMMENDATION  - FOR NOW, NO NEED FOR AN UMBRELLA",
                                style:
                                    TextStyle(fontSize: 9, color: Colors.white),
                              )),
                        ),
                        const Verticalspace(value: 15),

                        //forecast cards
                        const Text(
                          "Forecasts",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 76, 0, 51)),
                        ),
                        const Verticalspace(value: 10),

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
                              //Horizontalspace(value: 5),
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
                              // Horizontalspace(value: 5),
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
                              // Horizontalspace(value: 5),
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
                              // Horizontalspace(value: 5),
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
                              // Horizontalspace(value: 5),
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

            //17 DAYS FORECAST
            FutureBuilder(
              future: theWeather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
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
                // final currentWetData = data["list"][0];
                // final currentTemp = currentWetData["main"]["temp"];
                // final currentSky = currentWetData["weather"][0]["main"];
                // final currentDescription =
                //     currentWetData["weather"][0]["description"];
                // final pressure = currentWetData["main"]["pressure"];
                // final windSpeed = currentWetData["wind"]["speed"];
                // final humidity = currentWetData["main"]["humidity"];
                // final wIcon = Uri.parse(
                //     "https://openweathermap.org/img/w/${currentWetData["weather"][0]["icon"]}");

                String fdday(int index) {
                  final day = DateTime.parse(data["list"][index]["dt_txt"]);
                  return DateFormat('EEE d').format(day);
                }

                String fdtime(int index) {
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
                  return data["list"][index]["weather"][0]["description"];
                }

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "${data["city"]["name"].toString().toUpperCase()} - ${data["city"]["country"]}",
                          style:
                              TextStyle(color: Color.fromARGB(255, 76, 0, 51)),
                        ),
                        const Verticalspace(value: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ForecastdaysCards(
                                day: fdday(7),
                                temp: "${convertTemp(fval(7))}°C",
                                time: fdtime(7),
                                iconImage: Image.network(
                                  ficon(7),
                                  width: 80,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                describe: fdescribe(7),
                              ),
                              //Horizontalspace(value: 5),
                              ForecastdaysCards(
                                day: fdday(12),
                                temp: "${convertTemp(fval(12))}°C",
                                time: fdtime(12),
                                iconImage: Image.network(
                                  ficon(12),
                                  width: 80,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                describe: fdescribe(12),
                              ),

                              ForecastdaysCards(
                                day: fdday(17),
                                temp: "${convertTemp(fval(17))}°C",
                                time: fdtime(17),
                                iconImage: Image.network(
                                  ficon(17),
                                  width: 80,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                describe: fdescribe(17),
                              ),
                              // Horizontalspace(value: 5),
                              ForecastdaysCards(
                                day: fdday(28),
                                temp: "${convertTemp(fval(28))}°C",
                                time: fdtime(28),
                                iconImage: Image.network(
                                  ficon(28),
                                  width: 80,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                describe: fdescribe(28),
                              ),

                              ForecastdaysCards(
                                day: fdday(36),
                                temp: "${convertTemp(fval(36))}°C",
                                time: fdtime(36),
                                iconImage: Image.network(
                                  ficon(36),
                                  width: 80,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                describe: fdescribe(36),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
