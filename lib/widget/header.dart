import 'package:flutter/material.dart';
import '../screen/signin_page.dart';

AppBar Header(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.blueGrey,
    title: const Text(
      "Knitting Production & Planning",
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    actions: [
      MaterialButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SigninPage()),
                (Route<dynamic> route) => false,
          );
        },
        color: Colors.lightBlue[50],
        child: const Text("Sign Out"),
      ),
    ],
  );
}