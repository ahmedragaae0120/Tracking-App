import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/config/theme/app_theme.dart';
import 'package:tracking_app/core/resuable_comp/dialogs.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/routes_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_intent.dart';
import 'package:tracking_app/ui/tabs/profile_tab/widgets/item_carts_profile_widget.dart';
import 'package:tracking_app/ui/tabs/profile_tab/widgets/user_info_card.dart';
import 'language_part/Language_bottom_sheet/Wigets/language_button.dart';
import 'widgets/vehicle_info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(AppStrings.profile),
        actions: [
          const Icon(
            Icons.notifications_none,
            size: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 10,
            children: [
              UserInfoCard(
                onTap: () {
                  Navigator.pushNamed(context, RouteManager.editProfileScreen);
                },
              ),
              VehicleInfoCard(
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.translate_outlined,
                      color: ColorManager.black,
                      size: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        AppStrings.language,
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(color: ColorManager.black),
                      ),
                    ),
                    const Spacer(),
                    const LanguageButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LogoutLoadingState) {
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primaryColor,
                          ),
                        ),
                      );
                    }

                    if (state is LogoutSuccessState) {
                      toastMessage(
                          message: "Logout Successfully, Back to login",
                          tybeMessage: TybeMessage.positive);

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteManager.loginScreen,
                          (route) => false,
                        );
                      });
                    }

                    if (state is LogoutFailureState) {
                      Navigator.pop(context);
                      toastMessage(
                          message: "Error : ${state.message}",
                          tybeMessage: TybeMessage.negative);
                    }
                  },
                  child: ItemCartsProfileWidget(
                    title: AppStrings.logout,
                    icon: Icons.logout_outlined,
                    iconArrow: Icons.logout_outlined,
                    onAction: () {
                      Dialogs.confirmLogout(
                        context,
                        () => Navigator.pop(context),
                        () => context.read<AuthCubit>().doIntent(LogoutIntent()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
