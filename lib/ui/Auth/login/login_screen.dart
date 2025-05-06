import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/resuable_comp/custom_text_field.dart';
import 'package:tracking_app/core/resuable_comp/text_button.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/resuable_comp/validator.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/config.dart';
import 'package:tracking_app/core/utils/routes_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_intent.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final cacheHelper = getIt<CacheHelper>();
  bool _isPasswordVisible = false;

  void _validateAndLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().doIntent(
            SignInIntent(
              rememberMe: isChecked,
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    setTokenNull();
  }

  void setTokenNull() async {
    await cacheHelper.removeData(Constant.tokenKey);
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.login),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteManager.mainScreen, (_) => false);
            toastMessage(
              message: AppStrings.loginSuccessfully,
              tybeMessage: TybeMessage.positive,
            );
          }
          if (state is LoginErrorState) {
            toastMessage(
              message: state.message.toString(),
              tybeMessage: TybeMessage.negative,
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        labelText: AppStrings.email,
                        hintText: AppStrings.enterYourForgetPassword,
                        obscureText: false,
                        controller: emailController,
                        keyboard: TextInputType.emailAddress,
                        validator: Validator.email,
                      ),
                      SizedBox(height: 4),
                      CustomTextField(
                        labelText: AppStrings.password,
                        hintText: AppStrings.enterPassword,
                        controller: passwordController,
                        keyboard: TextInputType.text,
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        validator: Validator.password,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    return isChecked
                                        ? ColorManager.pinkBase
                                        : ColorManager.white;
                                  },
                                ),
                                checkColor: isChecked
                                    ? ColorManager.white
                                    : ColorManager.pinkBase,
                                value: isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isChecked = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(width: 2),
                              Text(
                                AppStrings.rememberMe,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteManager.forgetPasswordScreen);
                            },
                            child: Text(
                              AppStrings.forgetpassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Config.screenHight! * 0.2),
                      CustomTextButton(
                        borderColor: ColorManager.pinkBase,
                        text: AppStrings.login,
                        color: ColorManager.pinkBase,
                        textColor: ColorManager.white,
                        onPressed: state is LoginLoadingState
                            ? null
                            : () {
                                _validateAndLogin(
                                  context,
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
