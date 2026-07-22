import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_map_placeholder.dart';

class CheckoutAddressCard extends StatefulWidget {
  const CheckoutAddressCard({super.key});

  @override
  State<CheckoutAddressCard> createState() => _CheckoutAddressCardState();
}

class _CheckoutAddressCardState extends State<CheckoutAddressCard> {
  String _address = 'Anshas, Al-sharqia, Egypt.';
  String _phone = '+20 101 840 3043';

  void _showChangeAddressDialog() {
    final addressCtrl = TextEditingController(text: _address);
    final phoneCtrl = TextEditingController(text: _phone);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                labelText: 'Delivery Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _address = addressCtrl.text.trim().isNotEmpty
                    ? addressCtrl.text.trim()
                    : _address;
                _phone = phoneCtrl.text.trim().isNotEmpty
                    ? phoneCtrl.text.trim()
                    : _phone;
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CheckoutMapPlaceholder(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.Location_Icon_UIA,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.Dark_Blue_900,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Home',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.Dark_Blue_900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _showChangeAddressDialog,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        minimumSize: const Size(48, 48),
                        tapTargetSize: MaterialTapTargetSize.padded,
                      ),
                      child: Text(
                        'Change',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.Dark_Blue_200,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _address,
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Mobile: $_phone',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
