import 'package:flutter/material.dart';

class Errorpage extends StatefulWidget {
  final String selectedCity;

  const Errorpage({super.key, required this.selectedCity});

  @override
  State<Errorpage> createState() => _ErrorpageState();
}

class _ErrorpageState extends State<Errorpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Icon(Icons.face_rounded, color: Color.fromARGB(255, 76, 0, 51),)),
              Expanded(
                  flex: 4,
                  child: Text("Unable to get weather details, Try these;",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 76, 0, 51),
                  ),))
            ],
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  Text(
                      "- Ensure you have a stable data connection\n- Ensure the city you searched is spelt correctly\n- Ensure the city exists")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
