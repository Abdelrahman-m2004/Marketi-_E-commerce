import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/orders/presentation/widgets/order_details_info_card.dart';
import 'package:marketi/features/orders/presentation/widgets/order_details_items_list.dart';
import 'package:marketi/features/orders/presentation/widgets/order_details_summary.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderDetailsView extends StatefulWidget {
  final int orderId;
  final String orderNumber;

  const OrderDetailsView({
    super.key,
    required this.orderId,
    required this.orderNumber,
  });

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  Map<String, dynamic>? _orderData;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiService().getOrderDetails(widget.orderId);
      setState(() {
        _orderData = response['data'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  Future<void> _cancelOrder() async {
    try {
      await ApiService().cancelOrder(widget.orderId);
      if (!mounted) return;
      AppSnackbar.showSuccess(context, 'Order cancelled successfully');
      await _fetchDetails();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
    }
  }

  Future<void> _retryPayment() async {
    try {
      final response = await ApiService().retryPayment(widget.orderId);
      final paymentUrl = response['data']['payment_url'];
      if (!mounted) return;
      AppSnackbar.showSuccess(context, paymentUrl ?? 'Retry initiated');
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
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
                    'Order #${widget.orderNumber}',
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

    if (_orderData == null && !_isLoading) return const SizedBox.shrink();

    final data = _isLoading
        ? {
            'items': <dynamic>[{}, {}],
            'total': '000.00',
            'status': 'pending',
            'created_at': '2026-01-01T00:00:00',
            'delivery_address': 'Loading address here...',
            'payment_type': 'cash_on_delivery',
          }
        : (_orderData ?? {});

    final items = (data['items'] as List?) ?? [];
    final total = double.tryParse(data['total']?.toString() ?? '0') ?? 0.0;
    final status = data['status'] ?? '';
    final date = (data['created_at'] ?? '').toString().split('T').first;
    final address = data['delivery_address'] ?? '';
    final paymentType = data['payment_type'] ?? '';

    return Skeletonizer(
      enabled: _isLoading,
      child: RefreshIndicator(
        onRefresh: _fetchDetails,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            OrderDetailsInfoCard(
              status: status,
              date: date,
              address: address,
              paymentType: paymentType,
            ),
            const SizedBox(height: 16),
            OrderDetailsItemsList(items: items),
            const SizedBox(height: 16),
            OrderDetailsSummary(total: total),
            const SizedBox(height: 16),
            if (!_isLoading && status.toLowerCase() == 'pending')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _cancelOrder,
                  child: const Text('Cancel Order'),
                ),
              ),
            const SizedBox(height: 12),
            if (!_isLoading &&
                status.toLowerCase() == 'pending' &&
                paymentType.toLowerCase() == 'online')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _retryPayment,
                  child: const Text('Retry Payment'),
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
