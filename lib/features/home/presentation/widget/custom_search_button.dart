import 'package:flutter/material.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 44,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          width: 1.5,
          color: Color(0xffD9E6FF),
        ),
      ),
      child: Row(
        //  mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
       
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 25),
          child: Icon(Icons.search,size: 24,),
        ),
        Text('What are you looking for ? ',
        style: TextStyle(
          fontWeight: FontWeight(400),
          fontSize: 16,
          color: Color(0xff929BAB),
        ),),
        Spacer(),
         Padding(
           padding: const EdgeInsets.only(right: 10),
           child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
          width: 1,
          color: Color(0xffD9E6FF),
        ),
            ),
            child: Icon(Icons.tune_sharp,size: 24,color: Color(0xff3F80FF),)),
         ),
      ],),
    );
  }
}