import 'package:flutter/material.dart';
import 'package:wecast/widgets/spacing.dart';

class ForecastCards extends StatelessWidget {
  final Image iconImage;
  final String time;
  final String temp;
  final String describe;

  const ForecastCards(
      {super.key, required this.iconImage, required this.time, required this.temp, required this.describe});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time, style: TextStyle(
                fontSize: 11,
                color: Color.fromARGB(255, 76, 0, 51),
                fontWeight: FontWeight.w500
            ),),
            Text(temp, style: TextStyle(
              fontSize: 10,
              color: Color.fromARGB(255, 76, 0, 51),
              fontWeight: FontWeight.w500
            ),),
            const Verticalspace(value: 2),
            iconImage,
            const Verticalspace(value: 2),
            Text(describe, style: TextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 76, 0, 51),
                fontWeight: FontWeight.w500
            ),),
          ],
        ),
      ),
    );
  }
}
