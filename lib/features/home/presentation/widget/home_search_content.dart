import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/app_dependencies.dart';
import 'package:marketi/core/common/widget/custom_appbar.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/widget/search_body_content.dart';
import 'package:marketi/features/home/presentation/widget/search_form.dart';

class HomeSearchContent extends StatefulWidget {
  const HomeSearchContent({super.key});

  @override
  State<HomeSearchContent> createState() => _HomeSearchContentState();
}

class _HomeSearchContentState extends State<HomeSearchContent> {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> searchResult = [];

   @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(appDependencies.productUseCase)..getProducts(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 50),
            CustomAppbar(
              icon: Icons.arrow_back_ios_new,
              ontap: () => Navigator.pop(context),
              customCircleAvatar: CustomCircleAvatar(
                imagePath: 'assets/image/avatare.png',
              ),
            ),
            SizedBox(height: 20),
           SearchForm(searchController: searchController,onChanged: (value) {
             
           },),
            SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    minTileHeight: 0,
                    title: const Text('Poplular Products'),
                    children: [SearchBodyContent(searchController: searchController,)],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

