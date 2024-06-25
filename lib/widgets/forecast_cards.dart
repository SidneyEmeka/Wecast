import 'package:flutter/material.dart';
import 'package:wecast/widgets/spacing.dart';

class ForecastCards extends StatelessWidget {
  final Image iconImage;
  final Widget text;
  final Widget value;

  const ForecastCards(
      {super.key, required this.iconImage, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            const Verticalspace(value: 5),
            iconImage,
            const Verticalspace(value: 5),
            value,
          ],
        ),
      ),
    );
  }
}
