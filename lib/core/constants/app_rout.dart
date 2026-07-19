import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
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
import 'package:marketi/features/Splash/presentation/page/spalshPage.dart';
import 'package:marketi/features/home/presentation/view/home_search.dart';
import 'package:marketi/features/home/presentation/view/home_view.dart';
import 'package:marketi/features/orders/presentation/views/my_orders_view.dart';
import 'package:marketi/features/brands/presentation/views/brands_screen.dart';
import 'package:marketi/features/productDetails/data/dataSourse/productDetlRemoteDataSourse.dart';
import 'package:marketi/features/productDetails/data/repository/productDetailsRepositoryImpl.dart';
import 'package:marketi/features/productDetails/domain/useCase/getAllProuductDet.dart';
import 'package:marketi/features/productDetails/presentation/cubit/product_detils_cubit.dart';
import 'package:marketi/features/productDetails/presentation/page/productDetailsView.dart';

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
        return MaterialPageRoute(builder: (_) => const CustomNavigationbar());
      case AppRoute.navigationbar:
        return MaterialPageRoute(builder: (_) => const CustomNavigationbar());
      case AppRoute.homeview:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoute.search:
        return MaterialPageRoute(builder: (_) => const HomeSearch());
      case AppRoute.myOrders:
        return MaterialPageRoute(builder: (_) => const MyOrdersView());
      case AppRoute.brands:
        return MaterialPageRoute(builder: (_) => const BrandsScreen());
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
      case AppRoute.productDetiles:
        final int id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ProductDetilsCubit(
              Getallprouductdet(
                repo: Productdetailsrepositoryimpl(
                  remotData: Productdetlremotedatasourse(
                    apiClient: ApiClient(),
                  ),
                ),
              ),
            )..getProductDetails(id),
            child: const ProductDetailsView(),
          ),
        );
      default:
        return null;
    }
  }
}

class AppRoute {
  static const String splach         = '/';
  static const String onBoarding     = '/onboarding';
  static const String home           = '/home';
  static const String navigationbar  = '/navigationbar';
  static const String homeview       = '/homeview';
  static const String search         = '/search';
  static const String catigoryScreen = '/category';
  static const String favScreen      = '/Fav';
  static const String productDetiles = '/productdetiles';
  static const String myOrders       = '/my-orders';
  static const String brands         = '/brands';
  static const String profile        = '/profile';
}
