import 'package:flutter/material.dart';
import 'package:marketi/features/home/presentation/widget/custom_search_button.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({super.key, required this.searchController, required this.onChanged});
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return Form(
     
      child: CustomSearchButton(
        readOnly: false,
        searchController: searchController,
        onChanged: onChanged,
      ),
    );
  }
}
