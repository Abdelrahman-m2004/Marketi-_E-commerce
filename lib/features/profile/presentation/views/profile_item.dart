import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/fonts/AppFonts.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: isDark ? Colors.white : Color(0xff001640)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: AppFonts.titleMedium.copyWith(
                color: isDark ? Colors.white : Color(0xff001640),
              ),
            ),
          ),
          trailing ??
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? Colors.white : Color(0xff001640),
              ),
        ],
      ),
    );
  }
}
