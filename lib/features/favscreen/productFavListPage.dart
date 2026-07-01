import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_appbar.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/features/favscreen/cubit/fav_product_cubit.dart';
import 'package:marketi/features/favscreen/product_item_card.dart';

class Productfavlistpage extends StatelessWidget {
  const Productfavlistpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icon: Icons.favorite,
        text: 'Favorites',
        customCircleAvatar: CustomCircleAvatar(
          imagePath: 'assets/image/image.png',
        ),
      ),
      body: BlocBuilder<FavProductCubit, FavProductState>(
        builder: (context, state) {
          if (state is FavProductLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FavProductLoaded) {
            return Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                  Text('All Products', style: AppFonts.headingLarge),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 2,
                        childAspectRatio: 0.65,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * 0.28,
                      ),
                      itemCount: state.FavProducts.favProducts.length,
                      itemBuilder: ((context, index) {
                        final Product = state.FavProducts.favProducts[index];
                        return ProductItemCard(
                          FavProduct: Product,
                          addButton: true,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is FavProductError) {
            return Center(child: Text(state.massages));
          }
          return SizedBox();
        },
      ),
    );
  }
}
