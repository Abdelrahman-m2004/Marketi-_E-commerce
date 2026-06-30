import 'package:flutter/material.dart';

class SuperTitleViewAll extends StatelessWidget {
  const SuperTitleViewAll({
    super.key,
     this.onTap, required this.superTitleName});
  final VoidCallback? onTap;
  final String superTitleName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(superTitleName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text('View all',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color(0xff3F80FF),
          ),
          ),),
      ],
    );
  }
}