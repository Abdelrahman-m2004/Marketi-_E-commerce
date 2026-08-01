import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/features/productDetails/domain/entites/productSizeEntity.dart';
import 'package:marketi/features/productDetails/presentation/cubit/product_detils_cubit.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  String? _selectedSize;
  double? _selectedSizePrice;
  bool _isAddingToCart = false;

  Future<void> _addToCart(int productId) async {
    // If product has sizes, user must select one
    if (_selectedSize == null) {
      // Check state to see if sizes exist
      final state = context.read<ProductDetilsCubit>().state;
      if (state is productDetailsLoaded &&
          state.productdetailsentity.sizes.isNotEmpty) {
        AppSnackbar.showError(context, 'Please select a size first');
        return;
      }
    }

    setState(() => _isAddingToCart = true);

    try {
      await ApiService().addToCart(
        productId: productId,
        quantity: 1,
        size: _selectedSize,
      );

      if (!mounted) return;

      AppSnackbar.showSuccess(context, 'Added to cart successfully!');

      // Navigate to cart tab (index 1) in navigation bar
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const CustomNavigationbar(initialIndex: 1),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
    } finally {
      if (mounted) setState(() => _isAddingToCart = false);
    }
  }

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
            final sizes = product.sizes.cast<Productsizeentity>();

            return SafeArea(
              child: Column(
                children: [
                  // ── AppBar ───────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                        const Spacer(),
                        Flexible(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  // ── Scrollable Content ───────────────────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main image
                          Image.network(
                            product.image,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const SizedBox(
                              height: 250,
                              child: Icon(Icons.image_not_supported, size: 80),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Thumbnail images
                          if (product.images.isNotEmpty)
                            SizedBox(
                              height: 70,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                itemCount: product.images.length,
                                itemBuilder: (_, index) {
                                  final img = product.images[index];
                                  return Container(
                                    width: 65,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blue),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      child: Image.network(
                                        img.image_Url,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                                Icons.image_not_supported),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          const SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Rating
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 18),
                                    const SizedBox(width: 4),
                                    Text(product.rating,
                                        style: AppFonts.bodyMedium),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Name
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),

                                // Description
                                Text(product.descrption,
                                    style: AppFonts.bodyMedium),
                                const SizedBox(height: 20),

                                // Size selector
                                if (sizes.isNotEmpty) ...[
                                  const Text(
                                    "Select Size",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 8,
                                    children: sizes.map((s) {
                                      final isSelected =
                                          _selectedSize == s.size;
                                      return GestureDetector(
                                        onTap: () => setState(() {
                                          _selectedSize = s.size;
                                          _selectedSizePrice = s.price;
                                        }),
                                        child: Container(
                                          width: 55,
                                          height: 48,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? const Color(0xff3F80FF)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: isSelected
                                                  ? const Color(0xff3F80FF)
                                                  : Colors.blue,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Text(
                                            s.size,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.blue,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Bottom Bar ───────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Price",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            Text(
                              "${_selectedSizePrice ?? product.price} EGP",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3F80FF),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 160,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: _isAddingToCart
                                ? null
                                : () => _addToCart(product.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff3F80FF),
                              disabledBackgroundColor:
                                  const Color(0xff3F80FF).withValues(
                                      alpha: 0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: _isAddingToCart
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.shopping_cart,
                                    color: Colors.white),
                            label: Text(
                              _isAddingToCart ? "Adding..." : "Add To Cart",
                              style: const TextStyle(color: Colors.white),
                            ),
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
