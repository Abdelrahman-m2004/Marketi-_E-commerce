import 'package:flutter/material.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.addButton,
    this.productModel,
  });

  final ProductModel? productModel;
  final bool addButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: productModel != null && productModel!.id != 0
          ? () => Navigator.pushNamed(
                context,
                AppRoute.productDetiles,
                arguments: productModel!.id,
              )
          : null,
      child: Container(
        width: 155,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffD9E6FF).withValues(alpha: 0.6),
              blurRadius: 9,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ──────────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 88,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(
                      color: const Color(0xffD9E6FF),
                      child: productModel?.imageUrl?.isNotEmpty == true
                          ? Image.network(
                              productModel!.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            )
                          : const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: _FavoriteButton(
                          productId: productModel?.id ?? 0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),

            // ── Price + Rating ─────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${productModel?.price ?? ''} LE',
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '\u2606 ${productModel?.rating ?? ''}',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 2),

            // ── Name ───────────────────────────────────────────────
            Text(
              productModel?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold),
            ),

            // ── Add button ─────────────────────────────────────────
            if (addButton) ...[
              const SizedBox(height: 4),
              _AddButton(productId: productModel?.id ?? 0),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Favorite Button ──────────────────────────────────────────────────────────

class _FavoriteButton extends StatefulWidget {
  final int productId;
  const _FavoriteButton({required this.productId});

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool _isFav = false;
  bool _loading = false;

  Future<void> _toggle() async {
    if (_loading || widget.productId == 0) return;
    setState(() => _loading = true);
    try {
      if (_isFav) {
        await ApiService().removeFavorite(widget.productId);
      } else {
        await ApiService().addFavorite(widget.productId);
      }
      if (!mounted) return;
      setState(() => _isFav = !_isFav);
      AppSnackbar.showSuccess(
        context,
        _isFav ? 'Added to favorites!' : 'Removed from favorites',
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 4,
            ),
          ],
        ),
        child: _loading
            ? const Padding(
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                    strokeWidth: 1.5, color: Color(0xff3F80FF)),
              )
            : Icon(
                _isFav ? Icons.favorite : Icons.favorite_border,
                size: 14,
                color: _isFav
                    ? const Color(0xffFF3F50)
                    : const Color(0xff8C99B2),
              ),
      ),
    );
  }
}

// ─── Add to Cart Button ───────────────────────────────────────────────────────

class _AddButton extends StatefulWidget {
  final int productId;
  const _AddButton({required this.productId});

  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton> {
  bool _loading = false;

  Future<void> _onTap() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      await ApiService().addToCart(productId: widget.productId, quantity: 1);
      if (!mounted) return;
      AppSnackbar.showSuccess(context, 'Added to cart!');
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => const CustomNavigationbar(initialIndex: 1)),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: 26,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0xff3F80FF), width: 1.5),
        ),
        alignment: Alignment.center,
        child: _loading
            ? const SizedBox(
                height: 13,
                width: 13,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Color(0xff3F80FF)),
              )
            : const Text(
                'Add',
                style: TextStyle(
                  color: Color(0xff3F80FF),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
