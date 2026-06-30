import 'dart:async';

import 'package:flutter/material.dart';

class Spalshpage extends StatefulWidget {
  const Spalshpage({super.key});

  @override
  State<Spalshpage> createState() => _SpalshpageState();
}

class _SpalshpageState extends State<Spalshpage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/Onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/image/Logo_Splash_Screen.png')),
    );
  }
}
