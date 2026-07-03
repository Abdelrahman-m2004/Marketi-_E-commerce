import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:marketi/features/cart/data/models/cart_item_model.dart';
import 'package:marketi/core/Network/api_service.dart';


class CartItemCard extends StatefulWidget {
  final CartItemModel item;
  final VoidCallback onDelete;
  final VoidCallback onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  Future<void> _increment() async {
    final newQuantity = widget.item.quantity + 1;

    try {
      await ApiService().updateCartItem(
        itemId: widget.item.itemId,
        quantity: newQuantity,
      );

      setState(() {
        widget.item.quantity = newQuantity;
      });

      widget.onQuantityChanged();
    } catch (e) {
      debugPrint('UPDATE CART ERROR: $e');
    }
  }

  Future<void> _decrement() async {
    if (widget.item.quantity <= 1) return;

    final newQuantity = widget.item.quantity - 1;

    try {
      await ApiService().updateCartItem(
        itemId: widget.item.itemId,
        quantity: newQuantity,
      );

      setState(() {
        widget.item.quantity = newQuantity;
      });

      widget.onQuantityChanged();
    } catch (e) {
      debugPrint('UPDATE CART ERROR: $e');
    }
  }

  void _toggleFavorite() =>
      setState(() => widget.item.isFavorite = !widget.item.isFavorite);

  String _formatPrice(double price) =>
      price.toStringAsFixed(2).replaceAll('.', ',');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Light_Blue_900, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.item.imagePath,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
            )
          ),
          const SizedBox(width: 10),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Favorite
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.name,
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.Dark_Blue_900,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: _toggleFavorite,
                      child: Icon(
                        widget.item.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.item.isFavorite
                            ? AppColors.Dark_Blue_700
                            : AppColors.light_gray,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // Subtitle
                Text(
                  widget.item.subtitle,
                  style: AppFonts.fontMedium.copyWith(
                    color: AppColors.light_gray,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                // Price + Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: ${_formatPrice(widget.item.price)} EGP',
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.Dark_Blue_900,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.Star_Icon,
                          width: 13,
                          height: 13,
                          colorFilter: ColorFilter.mode(
                            AppColors.Gray_Scale,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          widget.item.rating.toString(),
                          style: AppFonts.fontMedium.copyWith(
                            color: AppColors.Gray_Scale,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Quantity controls
                Row(
                  children: [
                    CartQuantityButton(
                      onTap: widget.item.quantity == 1
                          ? widget.onDelete
                          : _decrement,
                      isDelete: widget.item.quantity == 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.Light_Blue_900,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.item.quantity}',
                            style: AppFonts.bodyMedium.copyWith(
                              color: AppColors.Dark_Blue_200,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CartQuantityButton(
                      onTap: _increment,
                      isDelete: false,
                      isPlus: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartQuantityButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isDelete;
  final bool isPlus;

  const CartQuantityButton({
    super.key,
    required this.onTap,
    required this.isDelete,
    this.isPlus = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.Light_Blue_900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isPlus
              ? Icons.add
              : isDelete
                  ? Icons.delete_outline_rounded
                  : Icons.remove,
          size: 16,
          color: isDelete ? AppColors.Dark_Red_100 : AppColors.Dark_Blue_200,
        ),
      ),
    );
  }
}
