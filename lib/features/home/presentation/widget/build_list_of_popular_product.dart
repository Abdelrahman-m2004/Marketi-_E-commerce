import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/product_item_card.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuildListOfPopularProduct extends StatelessWidget {
  const BuildListOfPopularProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Skeletonizer(
            enabled: true,
            child: SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return ProductItemCard(
                    productModel: HomeHelper.fakeProducts[index],
                    addButton: false,
                  );
                },
              ),
            ),
          );
        }

        if (state is ProductLoaded) {
          return SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return ProductItemCard(
                  productModel: HomeHelper.popular(state.products)[index],
                  addButton: false,
                );
              },
            ),
          );
        }

        if (state is ProductError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
