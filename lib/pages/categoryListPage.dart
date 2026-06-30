import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/categoryItemCard.dart';
import 'package:marketi/core/common/widget/custom_appbar.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/cubit/category_cubit.dart';

class Categorylistpage extends StatelessWidget {
  const Categorylistpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        icon: Icons.category,
        text: 'Categories',
        customCircleAvatar: CustomCircleAvatar(
          imagePath: 'assets/image/image.png',
        ),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is categoryLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is categoryloaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                  Text('All Categories', style: AppFonts.headingLarge),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1,
                          ),
                      itemCount: state.categories.length,
                      itemBuilder: ((context, index) {
                        final category = state.categories[index];
                        return CategoryItemCard(categoryModel: category);
                      }),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is categoryErorr) {
            return Center(child: Text(state.massage));
          }
          return SizedBox();
        },
      ),
    );
  }
}
