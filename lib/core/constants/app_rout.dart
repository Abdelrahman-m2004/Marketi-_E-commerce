import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/features/categoryList/cubit/category_cubit.dart';
import 'package:marketi/features/categoryList/data/ApiServices/categoryDataService.dart';
import 'package:marketi/features/categoryList/data/repository/categoryRepository.dart';
import 'package:marketi/features/categoryList/categoryListPage.dart';
import 'package:marketi/features/favscreen/cubit/fav_product_cubit.dart';
import 'package:marketi/features/favscreen/data/Api/FavRequest.dart';
import 'package:marketi/features/favscreen/data/repos/favProductRepo.dart';
import 'package:marketi/features/favscreen/productFavListPage.dart';
import 'package:marketi/features/splash&bording/Home.dart';
import 'package:marketi/features/splash&bording/onboardingPage.dart';
import 'package:marketi/features/splash&bording/spalshPage.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splach:
        return MaterialPageRoute(builder: (_) => const Spalshpage());
      case AppRoute.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case AppRoute.catigoryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CategoryCubit(
              Categoryrepository(Categorydataservice(ApiClient())),
            )..GetCategories(),
            child: const Categorylistpage(),
          ),
        );
      case AppRoute.favScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => FavProductCubit(
              Favproductrepo(apiRequest: Favrequest(apiClient: ApiClient())),
            )..GetFavProducts(),
            child: const Productfavlistpage(),
          ),
        );
      default:
        return null;
    }
  }
}

class AppRoute {
  static const String splach = '/';
  static const String onBoarding = '/Onboarding';
  static const String home = '/home';
  static const String catigoryScreen = '/category';
  static const String favScreen = '/Fav';
}
