import 'package:flutter/material.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/marketi_e_ommerce.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(
    MarketiECommerce(
      appRouter: AppRouter(),
      initialRoute: AppRoute.splach,
    ),
  );
}
