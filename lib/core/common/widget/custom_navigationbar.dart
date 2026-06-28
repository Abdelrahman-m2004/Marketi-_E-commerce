import 'package:flutter/material.dart';

class CustomNavigationbar extends StatefulWidget {
  const CustomNavigationbar({super.key});

  @override
  State<CustomNavigationbar> createState() => _CustomNavigationbarState();
}

class _CustomNavigationbarState extends State<CustomNavigationbar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blueAccent);
            }
            return const TextStyle(fontSize: 14);
          }),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: NavigationBar(
            indicatorColor: Colors.transparent,
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            height: 85,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.house_outlined, size: 32, fontWeight: FontWeight(600)),
                selectedIcon: Icon(Icons.house_outlined,size: 32, fontWeight: FontWeight(600),color: Colors.blue,),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 32,
                  fontWeight: FontWeight(600),
                  
                ),
                selectedIcon: Icon(Icons.shopping_cart_outlined,size: 32, fontWeight: FontWeight(600),color: Colors.blue,),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.favorite,
                  size: 32,
                  fontWeight: FontWeight(600),
                ),
                selectedIcon: Icon(Icons.favorite,size: 32, fontWeight: FontWeight(600),color: Colors.blue,),
                label: 'Favorite',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu, size: 32, fontWeight: FontWeight(600)),
                selectedIcon: Icon(Icons.menu,size: 32, fontWeight: FontWeight(600),color: Colors.blue,),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


