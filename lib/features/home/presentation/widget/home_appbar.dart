import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..getProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          String name;
          String? avatarUrl;

          if (state is ProfileSuccess) {
            name = state.userEntity.name;
            avatarUrl = state.userEntity.profileImage;
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  avatarUrl != null && avatarUrl.isNotEmpty
                      ? Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.Light_Blue_700,
                              width: 1.5,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              avatarUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  CustomCircleAvatar(imagePath: avatarUrl!),
                            ),
                          ),
                        )
                      : CustomCircleAvatar(imagePath: avatarUrl),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoute.profile),
                    child: Text(
                      'Hi $name',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                     onTap: () =>  Navigator.pushNamed(context, AppRoute.notification),
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      size: 36,
                    ),
                  ),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
