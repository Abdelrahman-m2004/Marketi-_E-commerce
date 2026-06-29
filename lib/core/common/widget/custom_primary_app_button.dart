import 'package:flutter/material.dart';

class CustomPrimaryAppButton extends StatelessWidget {
  final String buttonText;
  const CustomPrimaryAppButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        
      },
      child: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(14)
            ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                ),),
          ),
        ),
    );
  }
}
