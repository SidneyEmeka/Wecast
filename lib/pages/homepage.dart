import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //Reusables
    double w = MediaQuery.of(context).size.width;

    Widget verticalSpace(double value) {
      return SizedBox(
        height: value,
      );
    }

    Widget forecastCards() {
      return Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              const Text(
                "03:00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              verticalSpace(10),
              const Icon(
                Icons.cloud,
                size: 32,
              ),
              verticalSpace(10),
              const Text(
                "301.2 F",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget infoCards(Icon icon, Widget text, Widget value) {
      return Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              icon,
              verticalSpace(10),
              text,
              verticalSpace(10),
              value,
            ],
          ),
        ),
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
      body: Padding(
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
                    const Text(
                      "300 F",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(15),
                    const Icon(
                      Icons.cloud,
                      size: 40,
                    ),
                    verticalSpace(15),
                    const Text(
                      "Rainy",
                      style: TextStyle(
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
                  forecastCards(),
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
                  child: infoCards(
                    const Icon(Icons.water_drop),
                    const Text(
                      "Humidity",
                      style: TextStyle(fontSize: 10),
                    ),
                    const Text("94"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: infoCards(
                    const Icon(Icons.wind_power_outlined),
                    const Text(
                      "Wind Speed",
                      style: TextStyle(fontSize: 10),
                    ),
                    const Text("7.67"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: infoCards(
                    const Icon(Icons.beach_access),
                    const Text(
                      "Pressure",
                      style: TextStyle(fontSize: 10),
                    ),
                    const Text("1006"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
