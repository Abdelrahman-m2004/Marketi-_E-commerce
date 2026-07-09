import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/cart/presentation/views/cart_view.dart';
import 'package:marketi/features/payment/data/models/payment_model.dart';
import 'package:marketi/features/payment/presentation/views/payment_details_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaymentsView extends StatefulWidget {
  const PaymentsView({super.key});

  @override
  State<PaymentsView> createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<PaymentsView> {
  List<PaymentModel> _payments = [];
  bool _isLoading = true;
  String? _error;

  static final _skeletonPayments = List.generate(
    4,
    (_) => PaymentModel(
      id: 0,
      paymentNumber: 'PAY-XXXXXXXX',
      amount: '000.00',
      status: 'pending',
      paymentMethod: 'cash_on_delivery',
      gateway: 'cod',
      order: OrderModel(
        id: 0,
        orderNumber: 'ORD-XXXXXXXX',
        status: 'pending',
        total: '000.00',
        address: 'Loading address here...',
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _fetchPayments();
  }

  Future<void> _fetchPayments() async {
    try {
      final data = await ApiService().getPayments();
      setState(() {
        _payments = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  CustomBackButton(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const CartView()),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Payments',
                    style: AppFonts.headingLarge.copyWith(
                      color: AppColors.Dark_Blue_900,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: AppFonts.bodyMedium.copyWith(color: AppColors.Dark_Red_100),
          textAlign: TextAlign.center,
        ),
      );
    }

    final items = _isLoading ? _skeletonPayments : _payments;

    if (!_isLoading && items.isEmpty) {
      return Center(
        child: Text(
          'No payments yet',
          style: AppFonts.titleMedium.copyWith(color: AppColors.light_gray),
        ),
      );
    }

    return Skeletonizer(
      enabled: _isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _PaymentCard(
            payment: items[index],
            onTap: _isLoading ? null : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentDetailsView(payment: items[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final PaymentModel payment;
  final VoidCallback? onTap;

  const _PaymentCard({required this.payment, this.onTap});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':    return Colors.green;
      case 'pending': return const Color(0xFFF59E0B);
      case 'failed':  return AppColors.Dark_Red_100;
      default:        return AppColors.Dark_Blue_200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  payment.paymentNumber,
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.Dark_Blue_900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(payment.status).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    payment.status,
                    style: AppFonts.captionBold.copyWith(
                      color: _statusColor(payment.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: AppColors.Light_Blue_900, thickness: 1),
            const SizedBox(height: 10),
            _InfoRow(label: 'Order', value: payment.order.orderNumber),
            const SizedBox(height: 6),
            _InfoRow(label: 'Amount', value: 'EGP ${payment.amount}'),
            const SizedBox(height: 6),
            _InfoRow(label: 'Method', value: payment.paymentMethod.replaceAll('_', ' ')),
            const SizedBox(height: 12),
            Row(
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
                Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.Dark_Blue_200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppFonts.bodyMedium.copyWith(color: AppColors.navy)),
        Text(value, style: AppFonts.bodyMedium.copyWith(
          color: AppColors.Dark_Blue_900, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
