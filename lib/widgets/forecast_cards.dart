import 'package:flutter/material.dart';
import 'package:wecast/widgets/spacing.dart';

class ForecastCards extends StatelessWidget {
  final Image icon;
  final Widget text;
  final Widget value;

  const ForecastCards(
      {super.key, required this.icon, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            text,
            const Verticalspace(value: 10),
            icon,
            const Verticalspace(value: 10),
            value,
          ],
        ),
      ),
    );
  }
}
