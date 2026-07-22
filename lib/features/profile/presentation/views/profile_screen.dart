import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/auth/login/presentation/views/login_view.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/core/fonts/AppFonts.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/features/cart/presentation/views/cart_view.dart';
import 'package:marketi/features/orders/presentation/views/my_orders_view.dart';
import 'package:marketi/features/payment/presentation/views/payments_view.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_state.dart';
import 'package:marketi/features/profile/presentation/views/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

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

  static Widget _dot({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) => Positioned(
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

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotifications = true;
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
            return Center(
              child: Text("Failed to load profile: ${profileState.message}"),
            );
          }

          if (profileState is ProfileSuccess) {
            final cubit = context.read<ProfileCubit>();
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              Text(
                                'My Profile',
                                style: AppFonts.titleLarge.copyWith(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xff001640),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartView(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.shopping_cart_outlined),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // ─── Avatar Ring ────────────────────────
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ProfileScreen._ring(isDark, 309, 216),
                              ProfileScreen._ring(isDark, 293, 204),
                              ProfileScreen._ring(isDark, 275, 192),
                              ProfileScreen._dot(top: 50, left: 14),
                              ProfileScreen._dot(top: 50, right: 14),
                              ProfileScreen._dot(bottom: 50, right: 14),
                              ProfileScreen._dot(bottom: 50, left: 14),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: cubit.profileImage != null
                                            ? ClipOval(
                                                child: Image.file(
                                                  cubit.profileImage!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : ClipOval(
                                                child: Image.network(
                                                  user.profileImage ?? '',
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      Image.asset(
                                                        'assets/image/image.png',
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                ),
                                              ),
                                      ),
                                      Positioned(
                                        right: 12,
                                        bottom: 2,
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<ProfileCubit>()
                                                .pickProfileImage();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.add_a_photo_outlined,

                                              size: 16,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),
                                  Text(
                                    user.name,
                                    style: AppFonts.titleLarge.copyWith(
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xff001640),
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
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),

                          ProfileItem(
                            icon: Icons.shopping_bag_outlined,
                            title: "My Orders",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MyOrdersView(),
                              ),
                            ),
                          ),
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),
                          ProfileItem(
                            icon: Icons.credit_card_outlined,
                            title: "Payments",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PaymentsView(),
                              ),
                            ),
                          ),
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),
                          ProfileItem(
                            icon: Icons.person_3_outlined,
                            title: "Account Preferences",
                          ),
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),
                          ProfileItem(
                            icon: Icons.notification_add_outlined,
                            title: "App Notifications",
                            trailing: Switch(
                              value: isNotifications,
                              onChanged: (value) {
                                setState(() {
                                  isNotifications = value;
                                });
                              },
                              activeTrackColor: const Color(0xff3F80FF),
                            ),
                          ),
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),
                          ProfileItem(
                            icon: Icons.dark_mode_outlined,
                            title: "Dark Mode",
                            trailing: Switch(
                              value: isDark,
                              onChanged: (_) =>
                                  context.read<ThemeCubit>().toggleTheme(),
                              activeTrackColor: const Color(0xff3F80FF),
                            ),
                          ),
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),
                          ProfileItem(
                            icon: Icons.star_rate_outlined,
                            title: "Rate Us",
                          ),
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),
                          ProfileItem(
                            icon: Icons.feedback_outlined,
                            title: "Provide Feedback",
                          ),
                          ProfileScreen._divider(isDark),
                          const SizedBox(height: 10),
                          ProfileItem(
                            icon: Icons.logout,
                            title: "Log Out",
                            onTap: () async {
                              await TokenStorage.clearToken();
                              if (!context.mounted) return;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginView(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                          ProfileScreen._divider(isDark),
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
}
