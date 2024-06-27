import 'package:flutter/material.dart';

class Errorpage extends StatefulWidget {
  const Errorpage({super.key});

  @override
  State<Errorpage> createState() => _ErrorpageState();
}

class _ErrorpageState extends State<Errorpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.face_rounded,
                    color: Color.fromARGB(255, 76, 0, 51),
                    size: 20,
                  )),
              Expanded(
                  flex: 6,
                  child: Text(
                    "Unable to get weather details, try these;",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 76, 0, 51),
                    ),
                  ))
            ],
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ensure you have a stable data connection.",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Ensure the city you searched is spelt correctly.",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Ensure the city exists.",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
