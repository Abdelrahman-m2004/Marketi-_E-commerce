import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/custom_appbar.dart';
import 'package:marketi/core/fonts/AppFonts.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_state.dart';
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:marketi/features/profile/presentation/views/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileFailure) {
            print(state.message);
            return Center(child: Text(state.message));
          } else if (state is ProfileSuccess) {
            print("${state.userEntity.name}");
            final isDark =
                context.read<ThemeCubit>().state.themeMode == ThemeMode.dark;

            return Scaffold(
              backgroundColor: isDark ? Colors.black : Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomAppbar(
                          shoppingcard: Icons.shopping_cart,
                          text: ' My Profile',

                          icon: Icons.arrow_back_ios_new,
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 309,
                              height: 216,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(220),
                                border: Border.all(
                                  color: isDark
                                      ? Color(0xff002B7F)
                                      : Color(0xffD9E6FF),
                                  width: 1.5,
                                ),
                              ),
                            ),

                            Container(
                              width: 293,
                              height: 204,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(220),
                                border: Border.all(
                                  color: isDark
                                      ? Color(0xff002B7F)
                                      : Color(0xffD9E6FF),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            Container(
                              width: 275,
                              height: 192,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(220),
                                border: Border.all(
                                  color: isDark
                                      ? Color(0xff002B7F)
                                      : Color(0xffD9E6FF),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            dot(top: 50, left: 14),
                            dot(top: 50, right: 14),
                            dot(bottom: 50, right: 14),
                            dot(bottom: 50, left: 14),

                            Column(
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
                                  child: Image.network(
                                    state.userEntity.profileImage ?? '',
                                    errorBuilder: (_, __, ___) {
                                      return Image.asset(
                                        'assets/image/image.png',
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 12),
                                Text(
                                  state.userEntity.name,
                                  style: AppFonts.titleLarge.copyWith(
                                    color: isDark
                                        ? Colors.white
                                        : Color(0xff001640),
                                  ),
                                ),
                                Text(
                                  state.userEntity.username,
                                  style: AppFonts.bodyMedium.copyWith(
                                    color: const Color(0xff67687E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 38),
                        ProfileItem(
                          icon: Icons.person_3_outlined,
                          title: "Account Preferences",
                        ),
                        Divider(
                          color: isDark ? Color(0xff1A1A1A) : Color(0xffDCDDE0),
                        ),
                        ProfileItem(
                          icon: Icons.credit_card_outlined,
                          title: "Subscription & Payment",
                        ),
                        Divider(
                          color: isDark ? Color(0xff1A1A1A) : Color(0xffDCDDE0),
                        ),
                        ProfileItem(
                          icon: Icons.notification_add_outlined,
                          title: "App Notifications",
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeTrackColor: Color(0xff3F80FF),
                          ),
                        ),
                        Divider(
                          color: isDark ? Color(0xff1A1A1A) : Color(0xffDCDDE0),
                        ),
                        ProfileItem(
                          icon: Icons.dark_mode_outlined,
                          title: "Dark Mode",
                          trailing: Switch(
                            value:
                                context.watch<ThemeCubit>().state.themeMode ==
                                ThemeMode.dark,
                            onChanged: (value) {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                            activeTrackColor: Color(0xff3F80FF),
                            //activeThumbColor: Color(0xff3F80FF),
                          ),
                        ),
                        Divider(
                          color: isDark ? Color(0xff1A1A1A) : Color(0xffDCDDE0),
                        ),
                        ProfileItem(
                          icon: Icons.star_rate_outlined,
                          title: "Rate Us",
                        ),
                        Divider(
                          color: isDark ? Color(0xff1A1A1A) : Color(0xffDCDDE0),
                        ),
                        ProfileItem(
                          icon: Icons.feedback,
                          title: "Provide Feedback",
                        ),
                        Divider(
                          color: isDark ? Color(0xff1A1A1A) : Color(0xffDCDDE0),
                        ),
                        ProfileItem(icon: Icons.logout, title: "Log Out"),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  static Widget dot({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
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
}
