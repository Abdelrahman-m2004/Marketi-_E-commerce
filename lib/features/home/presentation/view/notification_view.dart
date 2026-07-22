import 'package:flutter/material.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_appbar.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_empty_content.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_empty_illustration.dart';
import 'package:marketi/features/home/presentation/widget/notofication_emoity_content.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const CartAppbar(text: 'Notification',),
              const SizedBox(height: 24),
              const CartEmptyIllustration(),
              const SizedBox(height: 24),
              const NotoficationEmoityContent(),
              const SizedBox(height: 32),
              
            ],
          ),
        ),
      ),
    );
  }
}