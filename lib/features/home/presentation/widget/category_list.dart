import 'dart:math' as math show min;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_state.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';
import 'package:marketi/features/home/presentation/widget/category_item_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Grid: 2 rows × 120px cell + 10px spacing = 250px
const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  mainAxisExtent: 120,
);

const double _gridHeight = 120 * 2 + 10;

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Skeletonizer(
            enabled: true,
            child: _CategoryGrid(
              itemCount: math.min(HomeHelper.fakeCategory.length, 6),
              itemBuilder: (index) =>
                  CategoryItemCard(categoryModel: HomeHelper.fakeCategory[index]),
            ),
          );
        }

        if (state is Categoryloaded) {
          return _CategoryGrid(
            itemCount: math.min(state.categories.length, 6),
            itemBuilder: (index) =>
                CategoryItemCard(categoryModel: state.categories[index]),
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

class _CategoryGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;

  const _CategoryGrid({required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _gridHeight,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        gridDelegate: _gridDelegate,
        itemBuilder: (_, index) => itemBuilder(index),
      ),
    );
  }
}

// Keep old class for backward compatibility
class BuildListCategory extends StatelessWidget {
  const BuildListCategory({super.key, required this.state});
  final CategoryState state;

  @override
  Widget build(BuildContext context) {
    return _CategoryGrid(
      itemCount: math.min(HomeHelper.fakeCategory.length, 6),
      itemBuilder: (index) =>
          CategoryItemCard(categoryModel: HomeHelper.fakeCategory[index]),
    );
  }
}
