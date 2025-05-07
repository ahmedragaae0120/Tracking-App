  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resuable_comp/custom_text_field.dart';
import '../../../../../../core/resuable_comp/toast_message.dart';
import '../../../../../../core/resuable_comp/validator.dart';
import '../../../../../../core/utils/config.dart';
import '../../../../../../core/utils/routes_manager.dart';
import '../../../../../../core/utils/string_manager.dart';
import '../../../../../../core/utils/text_style_manager.dart';

import '../../../core/resuable_comp/text_button.dart';
import '../../../core/utils/colors_manager.dart';
import '../view_model/cubit/auth_cubit.dart';
import '../view_model/cubit/auth_intent.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateAndContinue() {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).doIntent(ForgetPassword(
        email: emailController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendEmailVerificationLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            ),
          );
        }

        if (state is SendEmailVerificationSuccessState) {
          if (state.isSent) {
            Navigator.pushNamed(
              context,
              RouteManager.emailVerificationScreen,
              arguments: emailController.text,
            );
          }
        }
        if (state is SendEmailVerificationErrorState) {
          Navigator.pop(context);
          toastMessage(
              message: "Error : ${state.message}",
              tybeMessage: TybeMessage.negative);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.password,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: Config.screenHight! * 0.03),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.forgetpassword,
                    style: AppTextStyle.medium18,
                  ),
                ),
                SizedBox(height: Config.screenHight! * 0.012),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.pleaseEnterEmailsAssociatedToUrAccount,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14,
                        color: ColorManager.grey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: Config.screenHight! * 0.05),

                /* Email Field */
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextField(
                    labelText: AppStrings.email,
                    hintText: AppStrings.email,
                    obscureText: false,
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    validator: Validator.email,
                  ),
                ),
                SizedBox(height: Config.screenHight! * 0.06),

                /* Confirm Button */
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextButton(
                    borderColor: ColorManager.pinkBase,
                    onPressed: _validateAndContinue,
                    text: AppStrings.confirm,
                    color: ColorManager.primaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
