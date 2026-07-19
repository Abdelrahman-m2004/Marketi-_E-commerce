import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/product_item_card.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

// addButton: true → height 190
class BuildListOfBestForYou extends StatelessWidget {
  const BuildListOfBestForYou({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Skeletonizer(
            enabled: true,
            child: SizedBox(
              height: 190,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => ProductItemCard(
                  productModel: HomeHelper.fakeProducts[index],
                  addButton: true,
                ),
              ),
            ),
          );
        }

        if (state is ProductLoaded) {
          return SizedBox(
            height: 190,
            child: ListView.builder(
              itemCount: HomeHelper.best(state.products).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => ProductItemCard(
                productModel: HomeHelper.best(state.products)[index],
                addButton: true,
              ),
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
