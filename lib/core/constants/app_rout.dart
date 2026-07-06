import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/features/Onbording/data/dataSourse/OnboardingLocalDataSourse.dart';
import 'package:marketi/features/Onbording/data/repository/OnboardingRepoImpli.dart';
import 'package:marketi/features/Onbording/presentation/cubit/onboarding_cubit.dart';
import 'package:marketi/features/Onbording/presentation/pages/OnboardingPage.dart';
import 'package:marketi/features/Splash/data/dataSourse/splashLocalData.dart';
import 'package:marketi/features/Splash/data/repository/splashRepositoryImpl.dart';
import 'package:marketi/features/Splash/domain/usecases/GetIsFirstTime.dart';
import 'package:marketi/features/Splash/domain/usecases/SaveIsFirstTime.dart';
import 'package:marketi/features/Splash/presentation/cubit/splash_cubit.dart';
import 'package:marketi/features/categoryList/domain/UseCase/getAllCategory.dart';
import 'package:marketi/features/categoryList/presentation/cubit/category_cubit.dart';
import 'package:marketi/features/categoryList/data/RemotDataSourse/categoryRemotDataSourse.dart';
import 'package:marketi/features/categoryList/data/repository/categoryRepositoryImpl.dart';
import 'package:marketi/features/categoryList/presentation/page/categoryListPage.dart';
import 'package:marketi/features/favscreen/domain/UseCase/getFavProduct.dart';
import 'package:marketi/features/favscreen/presentation/cubit/fav_product_cubit.dart';
import 'package:marketi/features/favscreen/data/RemotDatasourse/favRemotDataSourse.dart';
import 'package:marketi/features/favscreen/data/repository/favRepositoryImpl.dart';
import 'package:marketi/features/favscreen/presentation/page/productFavListPage.dart';
import 'package:marketi/features/Onbording/Home.dart';
import 'package:marketi/features/Splash/presentation/page/spalshPage.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splach:
        final repository = Splashrepositoryimpl(LocalData: Splashlocaldata());
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SplashCubit(
              isFirstTime: GetIsFirstTime(repos: repository),
              saveIsFirstTime: SaveIsFirstTime(repos: repository),
            )..ChackIsFristTime(),
            child: const SplashPage(),
          ),
        );
      case AppRoute.onBoarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OnboardingCubit(
              Onboardingrepoimpli(Onboardinglocaldatasourse()),
              SaveIsFirstTime(
                repos: Splashrepositoryimpl(LocalData: Splashlocaldata()),
              ),
            )..loadOnboarding(),
            child: const Onboardingpage(),
          ),
        );
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case AppRoute.catigoryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CategoryCubit(
              Getallcategory(
                repo: CategoryrepositoryImpl(
                  categoryRemotDataSourse(ApiClient()),
                ),
              ),
            )..GetCategories(),
            child: const Categorylistpage(),
          ),
        );
      case AppRoute.favScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => FavProductCubit(
              Getfavproduct(
                repo: favRepositoryImpl(
                  favRemoteData: favRemoteDataSourse(apiClient: ApiClient()),
                ),
              ),
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
  static const String onBoarding = '/onboarding';
  static const String home = '/home';
  static const String catigoryScreen = '/category';
  static const String favScreen = '/Fav';
}
