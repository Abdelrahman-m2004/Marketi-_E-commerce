import 'package:flutter/material.dart';
import 'package:marketi/core/fonts/AppFonts.dart';
import 'package:marketi/features/menu/presentation/view/item_drawer.dart';
import 'package:marketi/features/orders/presentation/views/my_orders_view.dart';
import 'package:marketi/features/payment/presentation/views/payments_view.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

class DrowerScreen extends StatelessWidget {
  final UserEntity user;
  const DrowerScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Image.network(
                      user.profileImage ?? '',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/image/image.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: AppFonts.buttonLarge.copyWith(
                          color: const Color(0xff51526C),
                        ),
                      ),
                      Text(
                        user.name,
                        style: AppFonts.buttonLarge.copyWith(
                          color: const Color(0xff001640),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_outlined,
                      color: Color(0xff001640),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: const ItemDrawer(text: "Buy Again", icon: Icons.refresh),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MyOrdersView()),
                  );
                },
                child: const ItemDrawer(
                  text: "My Orders",
                  icon: Icons.shopping_bag_outlined,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaymentsView()),
                  );
                },
                child: const ItemDrawer(
                  text: "Payments",
                  icon: Icons.credit_card_outlined,
                ),
              ),
              const SizedBox(height: 24),
              const ItemDrawer(
                text: "Account Settings",
                icon: Icons.settings_outlined,
              ),
              const SizedBox(height: 24),
              const ItemDrawer(text: "Support", icon: Icons.chat_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
