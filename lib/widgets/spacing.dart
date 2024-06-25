import 'package:flutter/material.dart';

//space for vertical space
class Verticalspace extends StatelessWidget {
  final double value;

  const Verticalspace({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}
//space for horizontal space
class Horizontalspace extends StatelessWidget {
  final double value;

  const Horizontalspace({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value,
    );
  }
}
