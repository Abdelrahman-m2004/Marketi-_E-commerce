import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class OrderDetailsInfoCard extends StatelessWidget {
  final String status;
  final String date;
  final String address;
  final String paymentType;

  const OrderDetailsInfoCard({
    super.key,
    required this.status,
    required this.date,
    required this.address,
    required this.paymentType,
  });

  Color _statusColor(String s) {
    switch (s.toLowerCase()) {
      case 'pending': return const Color(0xFFF59E0B);
      case 'delivered': return Colors.green;
      case 'cancelled': return AppColors.Dark_Red_100;
      default: return AppColors.Dark_Blue_200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Column(
        children: [
          _InfoRow(label: 'Status', value: status, valueColor: _statusColor(status)),
          const SizedBox(height: 8),
          _InfoRow(label: 'Date', value: date),
          const SizedBox(height: 8),
          _InfoRow(label: 'Address', value: address),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Payment',
            value: paymentType.replaceAll('_', ' ').toUpperCase(),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: AppFonts.bodyMedium.copyWith(color: AppColors.light_gray),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: AppFonts.bodyMedium.copyWith(
              color: valueColor ?? AppColors.Dark_Blue_900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
