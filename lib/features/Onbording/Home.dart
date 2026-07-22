import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Text('Home'),

      bottomNavigationBar: const CustomNavigationbar(),
    );
  }
}
