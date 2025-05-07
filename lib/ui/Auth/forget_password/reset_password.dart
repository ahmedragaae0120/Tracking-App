// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resuable_comp/custom_password_text_field.dart';
import '../../../../../../core/resuable_comp/toast_message.dart';
import '../../../../../../core/resuable_comp/validator.dart';
import '../../../../../../core/utils/config.dart';
import '../../../../../../core/utils/string_manager.dart';
import '../../../../../../core/utils/text_style_manager.dart';
import '../../../core/resuable_comp/text_button.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../view_model/cubit/auth_cubit.dart';
import '../view_model/cubit/auth_intent.dart';


class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/PutNewPassword';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    void _validateAndUpdatePassword() {
      if (_formKey.currentState!.validate()) {
        AuthCubit.get(context).doIntent(
            ResetPassword(email: email, NewPassword: passwordController.text));
      }
    }

    Config().init(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            ),
          );
        }

        if (state is ResetPasswordSuccessState) {
          if (state.isChanged) {
            toastMessage(
                message: "Success! \n Your password has been updated.",
                tybeMessage: TybeMessage.positive);

            // Wait for 2 seconds, then navigate to login
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamed(context, RouteManager.loginScreen);
            });
          }
        }

        if (state is ResetPasswordErrorState) {
          Navigator.pop(context);
          toastMessage(
              message: "Error : ${state.message}",
              tybeMessage: TybeMessage.negative);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.password),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 20,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.resetPassword,
                      style: AppTextStyle.medium18
                          .copyWith(color: ColorManager.blackBase),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.resetText,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regular14
                          .copyWith(color: ColorManager.grey),
                    ),
                  ),
                  SizedBox(height: Config.screenHight! * 0.012),
                  /* Password Field */
                  CustomPasswordField(
                    label: AppStrings.newPassword,
                    controller: passwordController,
                    validator: Validator.password,
                  ),

                  /* Confirm Password Field */
                  CustomPasswordField(
                    label: AppStrings.confirmPassword,
                    controller: confirmPasswordController,
                    validator: (value) => Validator.confirmPassword(
                        value, passwordController.text),
                  ),

                  /* Confirm Button */
                  CustomTextButton(
                    borderColor: ColorManager.pinkBase,
                    onPressed: _validateAndUpdatePassword,
                    text: AppStrings.confirm,
                    color: ColorManager.primaryColor,
                    textColor: ColorManager.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
