import 'package:flutter/material.dart';

class ForecastCards extends StatelessWidget {
  const ForecastCards({super.key});

  @override
  Widget build(BuildContext context) {
    Widget verticalSpace(double value) {
      return SizedBox(
        height: value,
      );
    }

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
  }

