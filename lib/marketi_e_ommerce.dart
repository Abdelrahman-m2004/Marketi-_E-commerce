import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/auth/login/presentation/views/login_view.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/core/theme/app_theme.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            home: const SplashDecider(),
            onGenerateRoute: appRouter.generateRoute,
          );
        },
      ),
    );
  }
}

class SplashDecider extends StatefulWidget {
  const SplashDecider({super.key});

  @override
  State<SplashDecider> createState() => _SplashDeciderState();
}

class _SplashDeciderState extends State<SplashDecider> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionOnly = prefs.getBool('session_only') ?? false;

    // If session_only, clear token on cold start (Remember Me was unchecked)
    if (sessionOnly) {
      await TokenStorage.clearToken();
      await prefs.remove('session_only');
    }

    final token = await TokenStorage.getToken();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => token != null
            ? const CustomNavigationbar()
            : const LoginView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
