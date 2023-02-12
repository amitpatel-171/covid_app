// ignore_for_file: prefer_const_constructors

import 'package:covid_app/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      title: "Flutter Covid-19 App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
