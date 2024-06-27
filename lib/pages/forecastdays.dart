import 'package:flutter/material.dart';
import 'package:wecast/widgets/spacing.dart';

class ForecastdaysCards extends StatelessWidget {
  final Image iconImage;
  final String day;
  final String time;
  final String temp;
  final String describe;

  const ForecastdaysCards(
      {super.key,
      required this.iconImage,
      required this.day,
      required this.temp,
      required this.describe,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 76, 0, 51),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 76, 0, 51),
                            fontWeight: FontWeight.bold),
                      ),
                      iconImage,
                      const Verticalspace(value: 8),
                      Text(
                        describe,
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 76, 0, 51),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        temp,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 76, 0, 51),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
