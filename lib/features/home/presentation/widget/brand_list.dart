import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/home/presentation/cubit/brand_cubit/brand_cubit.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';
import 'package:marketi/features/home/presentation/widget/brand_item_card.dart';

class BrandList extends StatelessWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, state) {
        if (state is BrandLoading) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: math.min(HomeHelper.fakeBrand.length, 3),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return BrandItemCard(brandModel: HomeHelper.fakeBrand[index]);
            },
          );
        }
        if (state is BrandLoaded) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: math.min(state.brands.length, 3),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return BrandItemCard(brandModel: state.brands[index]);
            },
          );
        }
        if (state is BrandError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
