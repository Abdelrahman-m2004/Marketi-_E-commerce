import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_map_placeholder.dart';

class CheckoutAddressCard extends StatefulWidget {
  final void Function(String address)? onAddressChanged;
  const CheckoutAddressCard({super.key, this.onAddressChanged});

  @override
  State<CheckoutAddressCard> createState() => _CheckoutAddressCardState();
}

class _CheckoutAddressCardState extends State<CheckoutAddressCard> {
  String _address = 'Anshas, Al-sharqia, Egypt.';
  String _phone = '+20 101 840 3043';

  void _showChangeAddressDialog() {
    final addressCtrl = TextEditingController(text: _address);
    final phoneCtrl = TextEditingController(text: _phone);
    String? phoneError;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
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
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: const OutlineInputBorder(),
                  errorText: phoneError,
                ),
                keyboardType: TextInputType.phone,
                onChanged: (_) {
                  if (phoneError != null) {
                    setDialogState(() => phoneError = null);
                  }
                },
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
                final phone = phoneCtrl.text.trim();
                final digits = phone.replaceAll(RegExp(r'\D'), '');
                if (digits.length < 10 || digits.length > 13) {
                  setDialogState(() =>
                      phoneError = 'Please enter a valid mobile number');
                  return;
                }
                setState(() {
                  _address = addressCtrl.text.trim().isNotEmpty
                      ? addressCtrl.text.trim()
                      : _address;
                  _phone = phone.isNotEmpty ? phone : _phone;
                });
                widget.onAddressChanged?.call(_address);
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
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
          CheckoutMapPlaceholder(address: _address),
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
