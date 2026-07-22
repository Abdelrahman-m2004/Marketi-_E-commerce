import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/cart/data/models/cart_item_model.dart';
import 'package:marketi/features/cart/presentation/views/cart_empty_view.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_appbar.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_subtotal_bar.dart';
import 'package:marketi/features/checkout/presentation/views/checkout_view.dart';
import 'package:marketi/features/payment/presentation/views/payments_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  final VoidCallback? onBack;
  const CartView({super.key, this.onBack});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItemModel> _items = [];
  bool isLoading = true;

  static final _skeletonItems = List.generate(
    3,
    (i) => CartItemModel(
      itemId: i,
      productId: 0,
      imagePath: '',
      name: 'Product Name Here',
      subtitle: 'Subtitle text',
      price: 000.00,
      rating: 0.0,
      quantity: 1,
    ),
  );


  Future<void> getCart() async {
    try {
      final response = await ApiService().getCart();
      final cartData = response['data'];
      final items = cartData['items'] as List;
      setState(() {
        _items = items.map((item) {
          return CartItemModel(
            itemId: item['id'],
            productId: item['product']['id'] ?? 0,
            imagePath: item['product']['main_image_url'],
            name: item['product']['name'],
            subtitle: item['size'] ?? '',
            price: double.parse(item['price'].toString()),
            rating: double.parse(item['product']['rating'].toString()),
            quantity: item['quantity'],
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      debugPrint("CART ERROR: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _onCheckout() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutView(
          itemCount: _totalItems,
          subtotal: _subtotal,
          deliveryFee: 10.00,
        ),
      ),
    );
  }

  double get _subtotal =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get _totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  void _deleteItem(int index) {
    final item = _items[index];
    // Remove from UI immediately (optimistic)
    setState(() => _items.removeAt(index));
    // Delete from server
    ApiService().removeCartItem(item.itemId).catchError((e) {
      // If API fails, restore the item
      setState(() => _items.insert(index, item));
      debugPrint('DELETE CART ERROR: $e');
    });
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading && _items.isEmpty) {
      return const CartEmptyView();
    }

    final displayItems = isLoading ? _skeletonItems : _items;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CartAppbar(onBack: widget.onBack),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products on Cart',
                        style: AppFonts.titleLarge.copyWith(
                          color: AppColors.Dark_Blue_900,
                        ),
                      ),
                      GestureDetector(
                        onTap: isLoading ? null : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PaymentsView(),
                            ),
                          );
                        },
                        child: Text(
                          'Payment history',
                          style: AppFonts.captionBold.copyWith(
                            color: AppColors.Dark_Blue_200,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Skeletonizer(
                enabled: isLoading,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: displayItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CartItemCard(
                      item: displayItems[index],
                      onDelete: isLoading ? () {} : () => _deleteItem(index),
                      onQuantityChanged: isLoading ? () {} : () => setState(() {}),
                    );
                  },
                ),
              ),
            ),
            CartSubtotalBar(
              itemCount: isLoading ? 0 : _totalItems,
              subtotal: isLoading ? 0 : _subtotal,
              onCheckout: isLoading ? null : _onCheckout,
            ),
          ],
        ),
      ),
    );
  }
}
