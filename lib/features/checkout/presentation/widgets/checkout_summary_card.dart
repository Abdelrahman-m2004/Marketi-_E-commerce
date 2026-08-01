import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class CheckoutSummaryCard extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final double deliveryFee;
  final double discount;

  const CheckoutSummaryCard({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.deliveryFee,
    this.discount = 0.0,
  });

  String _format(double amount) =>
      amount.toStringAsFixed(2).replaceAll('.', ',');

  @override
  Widget build(BuildContext context) {
    final total = subtotal + deliveryFee - discount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: 'Subtotal ($itemCount items)',
            value: 'EGP ${_format(subtotal)}',
          ),
          const SizedBox(height: 6),
          _SummaryRow(
            label: 'Delivery Fee',
            value: 'EGP ${_format(deliveryFee)}',
          ),
          if (discount > 0) ...[
            const SizedBox(height: 6),
            _SummaryRow(
              label: 'Discount',
              value: '- EGP ${_format(discount)}',
              isDiscount: true,
            ),
          ],
          const SizedBox(height: 8),
          _DashedLine(color: AppColors.Light_Blue_500),
          const SizedBox(height: 8),
          _SummaryRow(
            label: 'Total',
            value: 'EGP ${_format(total < 0 ? 0 : total)}',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isDiscount;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? AppFonts.bodyMedium.copyWith(
            color: AppColors.Dark_Blue_900,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )
        : isDiscount
            ? AppFonts.bodyMedium.copyWith(
                color: const Color(0xff22C55E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              )
            : AppFonts.bodyMedium.copyWith(
                color: AppColors.navy,
                fontSize: 13,
              );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}

class _DashedLine extends StatelessWidget {
  final Color color;

  const _DashedLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 5.0;
        const dashSpace = 4.0;
        final count =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(count, (_) {
            return Padding(
              padding: const EdgeInsets.only(right: dashSpace),
              child: Container(
                width: dashWidth,
                height: 1.5,
                color: color,
              ),
            );
          }),
        );
      },
    );
  }
}
