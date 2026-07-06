import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoute.onBoarding:
      //   return MaterialPageRoute(builder: (_) => const Onboarding());
      default:
        return null;
    }
  }
}

class AppRoute {
  static const String onBoarding = '/Onboarding';
}
