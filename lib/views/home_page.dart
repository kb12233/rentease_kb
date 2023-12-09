// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease_kb/controllers/login_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              LoginControl.signOut;
              Navigator.pushNamed(context, '/login');
            },
            icon: Icon(Icons.logout))
      ]),
      body: Center(
          child: Text(
        "LOGGED IN AS: ${user.email!}",
        style: TextStyle(
          fontSize: 20,
        ),
      )),
    );
  }
}
