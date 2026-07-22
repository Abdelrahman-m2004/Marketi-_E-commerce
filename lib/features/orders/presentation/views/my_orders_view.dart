import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/orders/data/models/order_model.dart';
import 'package:marketi/features/orders/presentation/widgets/order_card.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  List<OrderModel> _orders = [];
  bool _isLoading = true;
  String? _error;


  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final response = await ApiService().getOrders();
      final data = response['data']['data'] as List? ?? [];
      setState(() {
        _orders = data
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
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
                  const CustomBackButton(),
                  const SizedBox(width: 12),
                  Text(
                    'My Orders',
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: AppFonts.bodyMedium.copyWith(color: AppColors.Dark_Red_100),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_orders.isEmpty) {
      return Center(
        child: Text(
          'No orders yet',
          style: AppFonts.titleMedium.copyWith(color: AppColors.light_gray),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchOrders,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: _orders.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, index) => OrderCard(order: _orders[index]),
      ),
    );
  }
}
