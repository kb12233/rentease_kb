// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rentease_kb/components/my_button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Color(0xFF532D29);

    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Container(
                  child: Text(
                    "Let's find your",
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  child: Text(
                    "most Suitable",
                    style: TextStyle(
                        color: buttonColor,
                        fontSize: 20,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Property.",
                  style: TextStyle(
                      color: buttonColor,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // Image.asset(
          //   'lib/images/rentlogo.png',
          //   width: 200,  
          //   height: 200, 
          //   fit: BoxFit.fitHeight,
          //   //fit: BoxFit.fitWidth,
          // ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                height: 75,
                width: 300,
                child: MyButton(
                  buttonColor: buttonColor,
                  buttonText: 'GET STARTED',
                  onTap: () => Navigator.pushNamed(context, '/selectusertype'),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
