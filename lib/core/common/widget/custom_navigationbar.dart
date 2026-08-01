import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/features/cart/presentation/views/cart_view.dart';
import 'package:marketi/features/favscreen/data/RemotDatasourse/favRemotDataSourse.dart';
import 'package:marketi/features/favscreen/data/repository/favRepositoryImpl.dart';
import 'package:marketi/features/favscreen/domain/UseCase/getFavProduct.dart';
import 'package:marketi/features/favscreen/presentation/cubit/fav_product_cubit.dart';
import 'package:marketi/features/favscreen/presentation/page/productFavListPage.dart';
import 'package:marketi/features/home/presentation/view/home_view.dart';
import 'package:marketi/features/profile/presentation/views/profile_screen.dart';

class CustomNavigationbar extends StatefulWidget {
  static const String routename = '/navigationbar';
  final int initialIndex;

  const CustomNavigationbar({super.key, this.initialIndex = 0});

  @override
  State<CustomNavigationbar> createState() => _CustomNavigationbarState();
}

class _CustomNavigationbarState extends State<CustomNavigationbar> {
  late int _selectedIndex;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _screens = [
      const HomeView(),
      CartView(onBack: _goToHome),
      BlocProvider(
        create: (_) => FavProductCubit(
          Getfavproduct(
            repo: favRepositoryImpl(
              favRemoteData: favRemoteDataSourse(apiClient: ApiClient()),
            ),
          ),
        )..GetFavProducts(),
        child: const Productfavlistpage(),
      ),
      const ProfileScreen(),
    ];
  }

  void _goToHome() {
    setState(() => _selectedIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          indicatorColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) =>
              setState(() => _selectedIndex = index),
          height: 72,
          backgroundColor: isDark ? const Color(0xff111111) : Colors.white,
          destinations: [
            _dest(icon: Icons.home_outlined, label: 'Home', index: 0),
            _dest(icon: Icons.shopping_cart_outlined, label: 'Cart', index: 1),
            NavigationDestination(
              icon: Icon(Icons.favorite_border,
                  size: 28, color: _iconColor(isDark, 2)),
              selectedIcon:
                  const Icon(Icons.favorite, size: 28, color: Colors.blue),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline,
                  size: 28, color: _iconColor(isDark, 3)),
              selectedIcon:
                  const Icon(Icons.person, size: 28, color: Colors.blue),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Color _iconColor(bool isDark, int index) {
    if (_selectedIndex == index) return Colors.blue;
    return const Color(0xff8C99B2);
  }

  NavigationDestination _dest({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return NavigationDestination(
      icon: Icon(icon, size: 28, color: _iconColor(isDark, index)),
      selectedIcon: Icon(icon, size: 28, color: Colors.blue),
      label: label,
    );
  }
}
