import 'package:flutter/material.dart';
import 'package:marketi/core/theming/colors.dart';

class CartBottomNavigationBar extends StatefulWidget {
  final int initialIndex;

  const CartBottomNavigationBar({super.key, this.initialIndex = 1});

  @override
  State<CartBottomNavigationBar> createState() => _CartBottomNavigationBarState();
}

class _CartBottomNavigationBarState extends State<CartBottomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        color: Colors.white,
      ),
      child: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 28, color: AppColors.light_gray),
            selectedIcon: Icon(Icons.home_outlined, size: 28, color: AppColors.Dark_Blue_100),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined, size: 28, color: AppColors.light_gray),
            selectedIcon: Icon(Icons.shopping_cart_outlined, size: 28, color: AppColors.Dark_Blue_100),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border, size: 28, color: AppColors.light_gray),
            selectedIcon: Icon(Icons.favorite, size: 28, color: AppColors.Dark_Blue_100),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu, size: 28, color: AppColors.light_gray),
            selectedIcon: Icon(Icons.menu, size: 28, color: AppColors.Dark_Blue_100),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
