import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomNavigationbar extends StatefulWidget {
  const CustomNavigationbar({super.key});

  @override
  State<CustomNavigationbar> createState() => _CustomNavigationbarState();
}

class _CustomNavigationbarState extends State<CustomNavigationbar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            );
          }
          return const TextStyle(fontSize: 14);
        }),
      ),
      child: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });

          switch (value) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;

            case 1:
              Navigator.pushReplacementNamed(context, '/category');
              break;

            case 2:
              Navigator.pushReplacementNamed(context, '/Fav');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.house_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorite'),
          NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}
