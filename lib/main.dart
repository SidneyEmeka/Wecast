import 'package:flutter/material.dart';
import 'package:wecast/pages/homepage.dart';

void main() {
  runApp(const Wecast());
}

class Wecast extends StatelessWidget {
  const Wecast({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wecast",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 76, 0, 51),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
