import 'dart:math' as math show min;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit_state.dart';

import 'package:marketi/features/home/presentation/widget/category_item_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is categoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is categoryloaded) {
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
        if (state is categoryErorr) {
          return Center(child: Text(state.massage));
        }

        return const SizedBox();
      },
    );
  }
}
