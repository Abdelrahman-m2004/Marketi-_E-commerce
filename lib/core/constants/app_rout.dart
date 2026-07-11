import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/features/home/presentation/view/home_search.dart';
import 'package:marketi/features/home/presentation/view/home_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.homeview:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoute.navigationbar:
        return MaterialPageRoute(builder: (_) => const CustomNavigationbar());
      case AppRoute.search:
        return MaterialPageRoute(builder: (_) => const HomeSearch());
      default:
        return null;
    }
  }
}

class AppRoute {
  static const String homeview     = '/homeview';
  static const String navigationbar = '/navigationbar';
  static const String search       = '/search';
  static const String onBoarding   = '/Onboarding';
  static const String profile      = 'profile';
}
