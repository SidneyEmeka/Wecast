import 'package:flutter/material.dart';

class ForecastCards extends StatelessWidget {
  final Icon icon;
  final Widget text;
  final Widget value;
  const ForecastCards({super.key, required this.icon, required this.text, required this.value});

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
              text,
              verticalSpace(10),
              icon,
              verticalSpace(10),
              value,
            ],
          ),
        ),
      );
    }
  }

