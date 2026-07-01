import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/core/theme/app_theme.dart';
import 'package:marketi/features/menu/presentation/view/drower_screen.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_state.dart';
import 'package:marketi/features/profile/presentation/views/profile_screen.dart';

class MarketiECommerce extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;
  const MarketiECommerce({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Marketi',
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            // onGenerateRoute: appRouter.generateRoute,
            // initialRoute: initialRoute,
            home: CustomNavigationbar(),
          );
        },
      ),
    );
  }
}
