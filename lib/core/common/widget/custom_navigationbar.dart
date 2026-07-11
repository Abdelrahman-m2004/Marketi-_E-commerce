import 'package:flutter/material.dart';
import 'package:marketi/features/cart/presentation/views/cart_view.dart';
import 'package:marketi/features/home/presentation/view/home_view.dart';

class CustomNavigationbar extends StatefulWidget {
  static const String routename = '/navigationbar';

  const CustomNavigationbar({super.key});

  @override
  State<CustomNavigationbar> createState() => _CustomNavigationbarState();
}

class _CustomNavigationbarState extends State<CustomNavigationbar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const CartView(),
    const Center(child: Text('Favorites Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Menu Screen', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              );
            }
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
          }),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: NavigationBar(
            indicatorColor: Colors.transparent,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) =>
                setState(() => _selectedIndex = index),
            height: 72,
            backgroundColor: Colors.white,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, size: 28),
                selectedIcon: Icon(Icons.home_outlined, size: 28, color: Colors.blue),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined, size: 28),
                selectedIcon: Icon(Icons.shopping_cart_outlined, size: 28, color: Colors.blue),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border, size: 28),
                selectedIcon: Icon(Icons.favorite, size: 28, color: Colors.blue),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu, size: 28),
                selectedIcon: Icon(Icons.menu, size: 28, color: Colors.blue),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
