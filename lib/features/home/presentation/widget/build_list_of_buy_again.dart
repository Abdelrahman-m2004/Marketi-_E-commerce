import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/product_item_card.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/helper/product_helper.dart';

class BuildListOfBuyAgain extends StatelessWidget {
  const BuildListOfBuyAgain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {

        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ProductLoaded) {
          final products = ProductHelper.buyAgain(state.products);

          return SizedBox(
            height: 190,
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ProductItemCard(
                  productModel: products[index],
                  addButton: true,
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
