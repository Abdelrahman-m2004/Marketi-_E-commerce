import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/orders/data/models/order_model.dart';
import 'package:marketi/features/orders/presentation/views/order_details_view.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFF59E0B);
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return AppColors.Dark_Red_100;
      default:
        return AppColors.Dark_Blue_200;
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
        boxShadow: [
          BoxShadow(
            color: AppColors.Light_Blue_900.withValues(alpha: 0.6),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order number + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.orderNumber}',
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.Dark_Blue_900,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(order.status).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: AppFonts.captionBold.copyWith(
                    color: _statusColor(order.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.Light_Blue_900, thickness: 1),
          const SizedBox(height: 10),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppFonts.bodyMedium.copyWith(color: AppColors.navy),
              ),
              Text(
                'EGP ${order.total.toStringAsFixed(2)}',
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.Dark_Blue_900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: AppFonts.bodyMedium.copyWith(color: AppColors.navy),
              ),
              Text(
                order.date,
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.Dark_Blue_900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // View Details button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailsView(
                    orderId: order.id,
                    orderNumber: order.orderNumber,
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'View Details',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.Dark_Blue_200,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.Dark_Blue_200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


