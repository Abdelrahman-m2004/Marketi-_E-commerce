import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/features/home/presentation/view/home_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.homeview:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoute.navigationbar:
        return MaterialPageRoute(builder: (_) => const CustomNavigationbar());
      default:
        return null;
    }    
  }
}

class AppRoute {
  static const String homeview = '/homeview';
  static const String navigationbar = '/navigationbar';
}
