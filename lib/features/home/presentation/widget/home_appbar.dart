import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key,required this.imagePath,required this.customerName});
  final String imagePath;
  final String customerName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          CustomCircleAvatar(imagePath: imagePath ,
          ),
      
          Text(
            '  Hi $customerName !' ,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight(600),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Icon(Icons.notifications_none_outlined,size: 40,)
        ],
      ),
    );
  }
}
