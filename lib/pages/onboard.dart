import 'package:flutter/material.dart';
import 'package:wecast/pages/homepage.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 76, 0, 51),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.cloudy_snowing,
            color: Colors.white,
            size: 150,
          ),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
              child: Container(

                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                  border: Border.all(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(15)
                ),
                width: MediaQuery.of(context).size.width/4,
                child: Text("Continue",
                style: TextStyle(
                  color: Color.fromARGB(255, 76, 0, 51),
                  fontSize: 10
                ),),
              ))
        ],
      )),
    );
  }
}
