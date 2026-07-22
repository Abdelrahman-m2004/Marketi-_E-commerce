import 'package:flutter/material.dart';
import 'package:marketi/core/constants/search_type_enum.dart';
import 'package:marketi/features/home/presentation/widget/home_search_content.dart';


class HomeSearch extends StatelessWidget {
   static const String rourename = '/search';
  final SearchType searchType;

  const HomeSearch({
    super.key,
    this.searchType = SearchType.general,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HomeSearchContent(searchType: searchType),
      ),
    );
  }
}