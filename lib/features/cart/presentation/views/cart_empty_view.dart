import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/cart_bottom_navigation_bar.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_appbar.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_empty_content.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_empty_illustration.dart';

class CartEmptyView extends StatelessWidget {
  const CartEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CartBottomNavigationBar(initialIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const CartAppbar(),
              const SizedBox(height: 24),
              const CartEmptyIllustration(),
              const SizedBox(height: 24),
              const CartEmptyContent(),
              const SizedBox(height: 32),
              CustomPrimaryAppButton(
                buttonText: 'Start Shopping',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CustomNavigationbar(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
