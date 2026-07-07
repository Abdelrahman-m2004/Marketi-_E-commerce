import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/product_item_card.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';

class BuildListOfPopularProduct extends StatelessWidget {
  const BuildListOfPopularProduct({super.key});

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

          return SizedBox(
            height: 155,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ProductItemCard(
                  productModel: state.products[index],
                  addButton: false,
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
