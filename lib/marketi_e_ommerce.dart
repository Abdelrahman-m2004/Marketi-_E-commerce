import 'package:flutter/material.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/features/brands/presentation/views/brands_screen.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BrandsScreen(),
    );
  }
}


