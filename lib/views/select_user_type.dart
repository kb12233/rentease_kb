// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rentease_kb/components/my_button.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  void userTapped() {
    print("NEXT!");
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Color(0xFF532D29);
    Color bC2 = Color(0xFFD2D1D3);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                child: Text(
                  "Select User Type",
                  style: TextStyle(
                      color: buttonColor,
                      fontSize: 26,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                      color: bC2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Lessor",
                          style: TextStyle(
                              color: buttonColor,
                              fontSize: 20,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                      color: bC2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Tenant",
                          style: TextStyle(
                              color: buttonColor,
                              fontSize: 20,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 200,
                  height: 70,
                  child: MyButton(
                    buttonColor: buttonColor,
                    buttonText: 'NEXT',
                    onTap: () => Navigator.pushNamed(context, '/register'),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
