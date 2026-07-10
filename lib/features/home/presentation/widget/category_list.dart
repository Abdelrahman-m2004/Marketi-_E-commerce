import 'dart:math' as math show min;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_state.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';

import 'package:marketi/features/home/presentation/widget/category_item_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return 
          Skeletonizer(
            enabled: true,
            child: BuildListCategory(state: state,),
          );
        } else if (state is Categoryloaded) {
          return SizedBox(
            height: 300,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: math.min(state.categories.length, 6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return CategoryItemCard(categoryModel: state.categories[index]);
              },
            ),
          );
        }
        if (state is CategoryErorr) {
          return Center(child: Text(state.massage));
        }

        return const SizedBox();
      },
    );
  }
}

class BuildListCategory extends StatelessWidget {
  const BuildListCategory({
    super.key, required this.state,
  });
  final CategoryState state;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: math.min(HomeHelper.fakeCategory.length, 6),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return CategoryItemCard(categoryModel: HomeHelper.fakeCategory[index]);
        },
      ),
    );
  }
}
