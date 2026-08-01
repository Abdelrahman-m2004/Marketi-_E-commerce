import 'package:flutter/material.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_address_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_appbar.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_delivery_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_payment_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_section_title.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_summary_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_voucher_field.dart';
import 'package:marketi/features/payment/presentation/views/payment_webview.dart';

class CheckoutView extends StatefulWidget {
  final int itemCount;
  final double subtotal;
  final double deliveryFee;

  const CheckoutView({
    super.key,
    this.itemCount = 3,
    this.subtotal = 1120.00,
    this.deliveryFee = 10.00,
  });

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  bool _isLoading = false;
  String _selectedPaymentType = 'cash_on_delivery';
  double _discount = 0.0;
  String _deliveryAddress = 'Anshas, Al-sharqia, Egypt.';

  Future<void> _placeOrder() async {
    setState(() => _isLoading = true);

    try {
      final response = await ApiService().placeOrder(
        deliveryAddress: _deliveryAddress,
        deliverySlotId: 1,
        notes: '',
        paymentType: _selectedPaymentType,
      );

      if (!mounted) return;

      final orderData = response['data']['order'];
      final paymentData = orderData['payment'];
      final String? paymentUrl = paymentData?['payment_url'] as String?;
      final int? paymentId = paymentData?['id'] != null
          ? (paymentData!['id'] as num).toInt()
          : null;
      final String message = response['message'] ?? 'Order placed successfully!';

      if (_selectedPaymentType == 'online' && paymentUrl != null && paymentId != null) {
        final success = await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder: (_) => PaymentWebView(
              url: paymentUrl,
              paymentId: paymentId,
            ),
          ),
        );

        if (!mounted) return;

        if (success == true) {
          await Future.delayed(const Duration(seconds: 2));
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const CustomNavigationbar()),
            (route) => false,
          );
        }
      } else {
        // cash_on_delivery
        AppSnackbar.showSuccess(context, message);
        await Future.delayed(const Duration(seconds: 2));
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const CustomNavigationbar()),
          (route) => false,
        );
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const CheckoutAppbar(),
                    const SizedBox(height: 16),
                    const CheckoutSectionTitle(title: 'Address'),
                    const SizedBox(height: 6),
                    CheckoutAddressCard(
                      onAddressChanged: (addr) =>
                          setState(() => _deliveryAddress = addr),
                    ),
                    const SizedBox(height: 14),
                    const CheckoutSectionTitle(title: 'Delivery time'),
                    const SizedBox(height: 6),
                    const CheckoutDeliveryCard(),
                    const SizedBox(height: 14),
                    const CheckoutSectionTitle(title: 'Payment'),
                    const SizedBox(height: 6),
                    CheckoutPaymentCard(
                      selectedPaymentType: _selectedPaymentType,
                      onPaymentTypeChanged: (value) =>
                          setState(() => _selectedPaymentType = value),
                    ),
                    const SizedBox(height: 8),
                    CheckoutVoucherField(
                      onVoucherApplied: (discountPercent) {
                        setState(() {
                          _discount = widget.subtotal * discountPercent / 100;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    const CheckoutSectionTitle(title: 'Payment'),
                    const SizedBox(height: 6),
                    CheckoutSummaryCard(
                      itemCount: widget.itemCount,
                      subtotal: widget.subtotal,
                      deliveryFee: widget.deliveryFee,
                      discount: _discount,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomPrimaryAppButton(
                      buttonText: 'Place Order',
                      onTap: _placeOrder,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
