import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';

class SignupPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onCountryCodeChanged;

  const SignupPhoneField({
    super.key,
    required this.controller,
    this.validator,
    this.onCountryCodeChanged,
  });

  @override
  State<SignupPhoneField> createState() => _SignupPhoneFieldState();
}

class _SignupPhoneFieldState extends State<SignupPhoneField> {
  static const List<Map<String, String>> _countries = [
    {'code': '+20', 'name': 'Egypt 🇪🇬'},
    {'code': '+966', 'name': 'Saudi Arabia 🇸🇦'},
    {'code': '+971', 'name': 'UAE 🇦🇪'},
    {'code': '+965', 'name': 'Kuwait 🇰🇼'},
    {'code': '+974', 'name': 'Qatar 🇶🇦'},
    {'code': '+973', 'name': 'Bahrain 🇧🇭'},
    {'code': '+968', 'name': 'Oman 🇴🇲'},
    {'code': '+962', 'name': 'Jordan 🇯🇴'},
    {'code': '+961', 'name': 'Lebanon 🇱🇧'},
    {'code': '+212', 'name': 'Morocco 🇲🇦'},
    {'code': '+1', 'name': 'USA 🇺🇸'},
    {'code': '+44', 'name': 'UK 🇬🇧'},
  ];

  String _selectedCode = '+20';

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: _countries.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final c = _countries[i];
          return ListTile(
            title: Text(c['name']!,
                style: AppFonts.bodyLarge
                    .copyWith(color: AppColors.Dark_Blue_900)),
            trailing: Text(c['code']!,
                style: AppFonts.bodyMedium
                    .copyWith(color: AppColors.Gray_Scale)),
            onTap: () {
              setState(() => _selectedCode = c['code']!);
              widget.onCountryCodeChanged?.call(c['code']!);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      style: AppFonts.bodyLarge.copyWith(color: AppColors.Dark_Blue_900),
      decoration: InputDecoration(
        hintText: '01XXXXXXXXX',
        hintStyle: AppFonts.fontMedium.copyWith(color: AppColors.light_gray),
        prefixIcon: GestureDetector(
          onTap: _showCountryPicker,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppIcons.Phone_Icon,
                  width: 22,
                  height: 22,
                  colorFilter:
                      ColorFilter.mode(AppColors.Gray_Scale, BlendMode.srcIn),
                ),
                const SizedBox(width: 6),
                Text(
                  _selectedCode,
                  style: AppFonts.bodyMedium
                      .copyWith(color: AppColors.Dark_Blue_900),
                ),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.Gray_Scale, size: 20),
              ],
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.Light_Blue_700, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.Dark_Blue_200, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.Dark_Red_100, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.Dark_Red_100, width: 1.5),
        ),
        errorStyle: TextStyle(color: AppColors.Dark_Red_100),
      ),
    );
  }
}
