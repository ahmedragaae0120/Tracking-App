import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
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
  SMITrigger? failTrigger; // مشغل لحالة الفشل في تسجيل الدخول
  SMITrigger? successTrigger; // مشغل لحالة النجاح في تسجيل الدخول
  SMIBool? isHandsUp; // حالة منطقية لرفع يدي الدب (عند إدخال كلمة المرور)
  SMIBool? isChecking; // حالة منطقية لتدقيق الدب (عند إدخال البريد الإلكتروني)
  SMINumber? lookNumber; // متغير رقمي للتحكم في حركة عيون الدب
  StateMachineController?
      stateMachineController; // وحدة التحكم في آلة حالة Rive
  Artboard? _riveArtboard; // لوحة الرسم التي تحتوي على الدب المتحرك
  void _validateAndLogin(BuildContext context) {
    isChecking?.change(false);
    isHandsUp?.change(false);
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().doIntent(
            SignInIntent(
              rememberMe: isChecked,
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    } else {
      failTrigger?.fire();
    }
  }

  @override
  void initState() {
    super.initState();
    setTokenNull();
    rootBundle
        .load('assets/animations/login_screen_character.riv')
        .then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(artboard, "State Machine 1");

      if (stateMachineController != null) {
        artboard.addController(stateMachineController!);
        // ربط المتغيرات المحلية بالمدخلات الموجودة في آلة حالة Rive

        for (var input in stateMachineController!.inputs) {
          // جميع القيم التى يتم مقارنتها هى موجودة فى animation نفسه فى الموقع بنفس الاسم
          if (input.name == "Check") {
            isChecking = input as SMIBool;
          } else if (input.name == "hands_up") {
            isHandsUp = input as SMIBool;
          } else if (input.name == "Look") {
            lookNumber = input as SMINumber;
          } else if (input.name == "fail") {
            failTrigger = input as SMITrigger;
          } else if (input.name == "success") {
            successTrigger = input as SMITrigger;
          }
        }
        setState(() => _riveArtboard = artboard);
      }
    });
  }

  // دالة لتحريك الدب للنظر حوله (عند التركيز على حقل البريد الإلكتروني)
  void lookAround() {
    isChecking?.change(true);
    isHandsUp?.change(false);
    lookNumber?.change(0);
  }

  // دالة لتحريك عيون الدب بناءً على طول نص البريد الإلكتروني

  void moveEyes(String value) {
    lookNumber?.change(
        value.length.toDouble()); // تغيير lookNumber بناءً على طول النص
  }

  // دالة لجعل الدب يغطي عينيه (عند التركيز على حقل كلمة المرور)
  void handsUpOnEyes() {
    if (_isPasswordVisible == false) {
      isHandsUp?.change(true); // تعيين isHandsUp إلى true
      isChecking?.change(false); // تعيين isChecking إلى false
    } else {
      isHandsUp?.change(false);
      isChecking?.change(true);
    }
  }

  void setTokenNull() async {
    await cacheHelper.removeData(Constant.tokenKey);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    stateMachineController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteManager.onBoardingScreen);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(AppStrings.login),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            setState(() {
              successTrigger?.fire();
            });
            Future.delayed(const Duration(seconds: 2), () {
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteManager.mainScreen,
                (route) => false,
              );
            });
            toastMessage(
              message: AppStrings.loginSuccessfully,
              tybeMessage: TybeMessage.positive,
            );
          }
          if (state is LoginErrorState) {
            failTrigger?.fire();
            setState(() {});
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
                      if (_riveArtboard != null)
                        SizedBox(
                          height: Config.screenHight! * 0.3,
                          child: Rive(
                            artboard: _riveArtboard!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      CustomTextField(
                        labelText: AppStrings.email,
                        hintText: AppStrings.enterYourForgetPassword,
                        obscureText: false,
                        controller: emailController,
                        keyboard: TextInputType.emailAddress,
                        validator: Validator.email,
                        onchanged: (value) => moveEyes(value),
                        onTap: () => lookAround(),
                      ),
                      SizedBox(height: 4),
                      CustomTextField(
                        labelText: AppStrings.password,
                        hintText: AppStrings.enterPassword,
                        controller: passwordController,
                        keyboard: TextInputType.text,
                        obscureText: !_isPasswordVisible,
                        onTap: () => handsUpOnEyes(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                              handsUpOnEyes();
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
