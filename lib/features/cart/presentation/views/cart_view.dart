import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/cart/data/models/cart_item_model.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_appbar.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:marketi/features/cart/presentation/widgets/cart_subtotal_bar.dart';
import 'package:marketi/features/cart/presentation/views/cart_empty_view.dart';
import 'package:marketi/features/checkout/presentation/views/checkout_view.dart';
import 'package:marketi/core/Network/api_service.dart';
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItemModel> _items = [];
  bool isLoading = true;
  Future<void> getCart() async {
    try {
      final response = await ApiService().getCart();

      final cartData = response['data'];
      final items = cartData['items'] as List;

      setState(() {
        _items = items.map((item) {
          return CartItemModel(
            itemId: item['id'],
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

      setState(() {
        isLoading = false;
      });
    }
  }

  double get _subtotal =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get _totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  void _deleteItem(int index) {
    setState(() => _items.removeAt(index));
  }
  @override
  void initState() {
    super.initState();
    getCart();
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (_items.isEmpty) {
      return const CartEmptyView();
    }
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
                  const CartAppbar(),
                  const SizedBox(height: 16),
                  Text(
                    'Products on Cart',
                    style: AppFonts.titleLarge.copyWith(
                      color: AppColors.Dark_Blue_900,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return CartItemCard(
                    item: _items[index],
                    onDelete: () => _deleteItem(index),
                    onQuantityChanged: () => setState(() {}),
                  );
                },
              ),
            ),
            CartSubtotalBar(
              itemCount: _totalItems,
              subtotal: _subtotal,
              onCheckout: () {
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
