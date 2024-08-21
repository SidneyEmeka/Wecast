import 'package:flutter/material.dart';

class InfoCards extends StatelessWidget {
  final Icon icon;
  final Widget text;
  final Widget value;
  const InfoCards({super.key, required this.icon, required this.text, required this.value});



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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
  }

