import 'package:flutter/material.dart';

class AdvertisingCard extends StatelessWidget {
  const AdvertisingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.17,
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14)
      ),
      child: Image.asset('assets/image/advertising.png',fit: BoxFit.fill),
    );
  }
}