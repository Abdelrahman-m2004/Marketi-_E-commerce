import 'package:flutter/material.dart';
import 'package:marketi/core/fonts/AppFonts.dart';
import 'package:marketi/features/menu/presentation/view/item_drawer.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

class DrowerScreen extends StatelessWidget {
  final UserEntity user;
  const DrowerScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    user.profileImage ?? '',
                    errorBuilder: (_, __, ___) {
                      return Image.asset(
                        'assets/image/image.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Column(
                    children: [
                      Text(
                        "Welcome",
                        style: AppFonts.buttonLarge.copyWith(
                          color: Color(0xff51526C),
                        ),
                      ),
                      Text(
                        user.name,
                        style: AppFonts.buttonLarge.copyWith(
                          color: Color(0xff001640),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.close_outlined,
                      color: Color(0xff001640),
                      weight: 20,
                    ),
                  ),
                ],
              ),
              Divider(),
              const SizedBox(height: 30),
              ItemDrawer(text: "Buy Again", icon: Icons.refresh),
              const SizedBox(height: 30),
              ItemDrawer(text: "My Orders", icon: Icons.shopping_bag_outlined),
              const SizedBox(height: 30),
              ItemDrawer(text: "Payments", icon: Icons.credit_card_outlined),
              const SizedBox(height: 30),
              ItemDrawer(
                text: "Account Settings",
                icon: Icons.settings_outlined,
              ),
              const SizedBox(height: 30),
              ItemDrawer(text: "Support", icon: Icons.chat_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
