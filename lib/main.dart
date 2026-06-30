import 'package:flutter/material.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/marketi_e_ommerce.dart';

void main() {

 WidgetsFlutterBinding.ensureInitialized();
 

  runApp( MarketiECommerce(
     appRouter: AppRouter(),
      initialRoute: AppRoute.onBoarding,
  ));
}

