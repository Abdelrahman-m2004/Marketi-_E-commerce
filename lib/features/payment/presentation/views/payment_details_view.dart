import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/payment/data/models/payment_model.dart';
import 'package:marketi/features/payment/presentation/views/payment_webview.dart';
import 'package:marketi/features/payment/presentation/views/payments_view.dart';

class PaymentDetailsView extends StatelessWidget {
  final PaymentModel payment;

  const PaymentDetailsView({
    super.key,
    required this.payment,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':    return Colors.green;
      case 'pending': return const Color(0xFFF59E0B);
      case 'failed':  return AppColors.Dark_Red_100;
      default:        return AppColors.Dark_Blue_200;
    }
  }

  bool get _isCashOnDelivery =>
      payment.paymentMethod.toLowerCase() == 'cash_on_delivery';

  Future<void> _handlePayNow(BuildContext context) async {
    if (_isCashOnDelivery) {
      // cash → show message → go to payments
      AppSnackbar.showSuccess(context, 'Order placed. Payment on delivery.');
      await Future.delayed(const Duration(seconds: 2));
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const PaymentsView()),
        (route) => false,
      );
    } else {
      // online → WebView → PaymentsView
      if (payment.paymentUrl == null) return;
      final success = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentWebView(
            url: payment.paymentUrl!,
            paymentId: payment.id,
          ),
        ),
      );
      if (!context.mounted) return;
      if (success == true) {
        await Future.delayed(const Duration(seconds: 2));
        if (!context.mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const PaymentsView()),
          (route) => false,
        );
      }
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
                  const CustomBackButton(),
                  const SizedBox(width: 12),
                  Text(
                    'Payment Details',
                    style: AppFonts.headingLarge.copyWith(
                      color: AppColors.Dark_Blue_900,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _InfoCard(
                      children: [
                        _HeaderRow(
                          title: payment.paymentNumber,
                          status: payment.status,
                          statusColor: _statusColor(payment.status),
                        ),
                        const SizedBox(height: 12),
                        Divider(color: AppColors.Light_Blue_900, thickness: 1),
                        const SizedBox(height: 12),
                        _DetailRow(label: 'Order No', value: payment.order.orderNumber),
                        const SizedBox(height: 10),
                        _DetailRow(label: 'Amount', value: 'EGP ${payment.amount}'),
                        const SizedBox(height: 10),
                        _DetailRow(label: 'Method', value: payment.paymentMethod.replaceAll('_', ' ')),
                        const SizedBox(height: 10),
                        _DetailRow(label: 'Gateway', value: payment.gateway),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _InfoCard(
                      children: [
                        Text('Order Info',
                            style: AppFonts.titleMedium.copyWith(
                              color: AppColors.Dark_Blue_900,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 12),
                        Divider(color: AppColors.Light_Blue_900, thickness: 1),
                        const SizedBox(height: 12),
                        _DetailRow(label: 'Order', value: payment.order.orderNumber),
                        const SizedBox(height: 10),
                        _DetailRow(label: 'Status', value: payment.order.status),
                        const SizedBox(height: 10),
                        _DetailRow(label: 'Total', value: 'EGP ${payment.order.total}'),
                        const SizedBox(height: 10),
                        _DetailRow(label: 'Address', value: payment.order.address),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Pay Now button — always show
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: CustomPrimaryAppButton(
                buttonText: _isCashOnDelivery ? 'Confirm Order' : 'Pay Now',
                onTap: () => _handlePayNow(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        children: children,
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  const _HeaderRow({required this.title, required this.status, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: AppFonts.titleMedium.copyWith(
              color: AppColors.Dark_Blue_900,
              fontWeight: FontWeight.w700,
            )),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(status,
              style: AppFonts.captionBold.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(label,
              style: AppFonts.bodyMedium.copyWith(color: AppColors.light_gray)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(value,
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.Dark_Blue_900,
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }
}
