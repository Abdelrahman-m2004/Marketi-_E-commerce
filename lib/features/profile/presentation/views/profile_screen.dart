import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/auth/login/presentation/views/login_view.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/core/fonts/AppFonts.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/features/orders/presentation/views/my_orders_view.dart';
import 'package:marketi/features/payment/presentation/views/payments_view.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_state.dart';
import 'package:marketi/features/profile/presentation/views/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..getProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileState is ProfileFailure) {
            return Center(child: Text("Failed to load profile: ${profileState.message}"));
          }

          if (profileState is ProfileSuccess) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                final isDark = themeState.themeMode == ThemeMode.dark;
                final user = profileState.userEntity;

                return Scaffold(
                  backgroundColor: isDark ? Colors.black : Colors.white,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // ─── Header ─────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'My Profile',
                                style: AppFonts.titleLarge.copyWith(
                                  color: isDark ? Colors.white : const Color(0xff001640),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // ─── Avatar Ring ────────────────────────
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              _ring(isDark, 309, 216),
                              _ring(isDark, 293, 204),
                              _ring(isDark, 275, 192),
                              _dot(top: 50, left: 14),
                              _dot(top: 50, right: 14),
                              _dot(bottom: 50, right: 14),
                              _dot(bottom: 50, left: 14),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.blue, width: 1.5),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        user.profileImage ?? '',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Image.asset(
                                          'assets/image/image.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    user.name,
                                    style: AppFonts.titleLarge.copyWith(
                                      color: isDark ? Colors.white : const Color(0xff001640),
                                    ),
                                  ),
                                  Text(
                                    '@${user.username}',
                                    style: AppFonts.bodyMedium.copyWith(
                                      color: const Color(0xff67687E),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // ─── Menu Items ─────────────────────────
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.shopping_bag_outlined,
                            title: "My Orders",
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const MyOrdersView())),
                          ),
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.credit_card_outlined,
                            title: "Payments",
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const PaymentsView())),
                          ),
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.person_3_outlined,
                            title: "Account Preferences",
                          ),
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.notification_add_outlined,
                            title: "App Notifications",
                            trailing: Switch(
                              value: true,
                              onChanged: (_) {},
                              activeTrackColor: const Color(0xff3F80FF),
                            ),
                          ),
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.dark_mode_outlined,
                            title: "Dark Mode",
                            trailing: Switch(
                              value: isDark,
                              onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                              activeTrackColor: const Color(0xff3F80FF),
                            ),
                          ),
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.star_rate_outlined,
                            title: "Rate Us",
                          ),
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.feedback_outlined,
                            title: "Provide Feedback",
                          ),
                          _divider(isDark),
                          ProfileItem(
                            icon: Icons.logout,
                            title: "Log Out",
                            onTap: () async {
                              await TokenStorage.clearToken();
                              if (!context.mounted) return;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginView()),
                                (route) => false,
                              );
                            },
                          ),
                          _divider(isDark),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  static Widget _divider(bool isDark) => Divider(
        color: isDark ? const Color(0xff1A1A1A) : const Color(0xffDCDDE0),
        height: 1,
      );

  static Widget _ring(bool isDark, double w, double h) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(220),
          border: Border.all(
            color: isDark ? const Color(0xff002B7F) : const Color(0xffD9E6FF),
            width: 1.5,
          ),
        ),
      );

  static Widget _dot({double? top, double? bottom, double? left, double? right}) =>
      Positioned(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: Container(
          width: 19,
          height: 19,
          decoration: const BoxDecoration(
            color: Color(0xffD9E6FF),
            shape: BoxShape.circle,
          ),
        ),
      );
}
