import 'package:flutter/material.dart';
import 'package:marketi/features/home/presentation/widget/home_search_content.dart';

class HomeSearch extends StatelessWidget {
  static const String rourename = '/search';
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeSearchContent(),
    );
  }
}