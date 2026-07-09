import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';

class CheckoutPaymentCard extends StatefulWidget {
  final ValueChanged<String> onPaymentTypeChanged;
  final String selectedPaymentType;

  const CheckoutPaymentCard({
    super.key,
    required this.onPaymentTypeChanged,
    required this.selectedPaymentType,
  });

  @override
  State<CheckoutPaymentCard> createState() => _CheckoutPaymentCardState();
}

class _CheckoutPaymentCardState extends State<CheckoutPaymentCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  final List<Map<String, String>> _options = [
    {'value': 'cash_on_delivery', 'label': 'Cash on delivery'},
    {'value': 'online', 'label': 'Online'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _selectOption(String value) {
    widget.onPaymentTypeChanged(value);
    setState(() => _isExpanded = false);
    _controller.reverse();
  }

  String _labelFor(String value) {
    return value == 'cash_on_delivery' ? 'Cash on delivery' : 'Online';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.Light_Blue_700, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.Cash_Icon,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      AppColors.Dark_Blue_900,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _labelFor(widget.selectedPaymentType),
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.Dark_Blue_900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _toggleDropdown,
                child: Text(
                  'Change',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.Dark_Blue_200,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Animated dropdown
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.Light_Blue_700, width: 1),
            ),
            child: Column(
              children: _options.map((option) {
                final isSelected =
                    option['value'] == widget.selectedPaymentType;
                return GestureDetector(
                  onTap: () => _selectOption(option['value']!),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.Light_Blue_900
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option['label']!,
                          style: AppFonts.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.Dark_Blue_200
                                : AppColors.Dark_Blue_900,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle_rounded,
                              color: AppColors.Dark_Blue_200, size: 18),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
