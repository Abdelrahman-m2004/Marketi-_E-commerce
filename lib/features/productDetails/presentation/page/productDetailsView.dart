import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/features/productDetails/presentation/cubit/product_detils_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetilsCubit, ProductDetilsState>(
        builder: (context, state) {
          if (state is productDetildLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is productDetailsErorr) {
            return Center(child: Text(state.message));
          }

          if (state is productDetailsLoaded) {
            final product = state.productdetailsentity;

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          Image.network(product.image, height: 250),

                          const SizedBox(height: 15),

                          SizedBox(
                            height: 75,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product.images.length,
                              itemBuilder: (_, index) {
                                final image = product.images[index];

                                return Center(
                                  child: Container(
                                    width: 70,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        image.image_Url,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber),

                                    Text(product.rating),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                Text(
                                  product.descrption,
                                  style: AppFonts.bodyMedium,
                                ),

                                const SizedBox(height: 20),

                                const Text(
                                  "Select Size",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 10),

                                SizedBox(
                                  height: 55,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product.sizes.length,
                                    itemBuilder: (_, index) {
                                      final size = product.sizes[index];

                                      return Container(
                                        width: 55,
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        child: Text(
                                          size.size,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Price"),

                            Text(
                              "${product.price} EGP",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        SizedBox(
                          width: 180,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text("Add To Cart"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
