import 'package:flutter/material.dart';
import 'package:marketi/features/home/presentation/widget/home_widget_content.dart';

class HomeView extends StatelessWidget {
  static const String routename = '/homeview';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeWidgetContent(),
    );
  }
}