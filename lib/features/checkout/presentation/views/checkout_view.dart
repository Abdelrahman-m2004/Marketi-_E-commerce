import 'package:flutter/material.dart';
import 'package:marketi/auth/congratulations/presentation/views/congratulations_view.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_address_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_appbar.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_delivery_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_payment_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_section_title.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_summary_card.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_voucher_field.dart';
import 'package:dio/dio.dart';

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

  Future<void> _placeOrder() async {
    setState(() => _isLoading = true);

    try {
      await ApiService().placeOrder(
        deliveryAddress: 'Anshas, Al-sharqia, Egypt.',
        deliverySlotId: 1,
        notes: '',
        paymentType: 'cash_on_delivery',
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CongratulationsView()),
        (route) => false,
      );
    }catch (e) {
      String message = e.toString();

      if (e is DioException) {
        message = e.response?.data.toString() ?? e.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 10),
        ),
      );
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
                    const CheckoutAddressCard(),
                    const SizedBox(height: 14),
                    const CheckoutSectionTitle(title: 'Delivery time'),
                    const SizedBox(height: 6),
                    const CheckoutDeliveryCard(),
                    const SizedBox(height: 14),
                    const CheckoutSectionTitle(title: 'Payment'),
                    const SizedBox(height: 6),
                    const CheckoutPaymentCard(),
                    const SizedBox(height: 8),
                    const CheckoutVoucherField(),
                    const SizedBox(height: 14),
                    const CheckoutSectionTitle(title: 'Payment'),
                    const SizedBox(height: 6),
                    CheckoutSummaryCard(
                      itemCount: widget.itemCount,
                      subtotal: widget.subtotal,
                      deliveryFee: widget.deliveryFee,
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
