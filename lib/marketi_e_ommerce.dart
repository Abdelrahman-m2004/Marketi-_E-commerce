import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/constants/app_rout.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: appRouter.generateRoute,
      //   initialRoute: initialRoute,
        home: CustomNavigationbar()
    );
  }
}


