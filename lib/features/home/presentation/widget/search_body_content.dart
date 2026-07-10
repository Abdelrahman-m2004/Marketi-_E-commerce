import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/product_item_card.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';
import 'package:marketi/features/home/presentation/widget/search_bubble.dart';

class SearchBodyContent extends StatelessWidget {
  const SearchBodyContent({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ProductLoaded) {
          if (searchController.text.isEmpty) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: HomeHelper.popular(state.products)
                  .map(
                    (product) => SearchBubble(
                      text: product.name,
                      onTap: () {
                        searchController.text = product.name;
                        context.read<ProductCubit>().search(product.name);
                      },
                    ),
                  )
                  .toList(),
            );
          }
          return GridView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.90,
              ),
              itemBuilder: (context, index) {
                return ProductItemCard(
                  productModel: state.products[index],
                  addButton: true,
                );
              },
          
          );
        }
        return SizedBox();
      },
    );
  }
}
