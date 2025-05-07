import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import '../../../../../../core/resuable_comp/toast_message.dart';
import '../../../../../../core/utils/config.dart';
import '../../../../../../core/utils/string_manager.dart';
import '../../../../../../core/utils/text_style_manager.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../view_model/cubit/auth_cubit.dart';
import '../view_model/cubit/auth_intent.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  const VerifyResetCodeScreen({super.key});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {
  bool isResendEnabled = false;
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    // ignore: prefer_const_constructors
    endTime = DateTime.now().add(Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendEmailVerificationLoadingState ||
            state is VerifyResetCodeLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            ),
          );
        }

        if (state is SendEmailVerificationSuccessState) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          if (state.isSent) {
            toastMessage(
                message: "The Code has been sent. Check your email.",
                tybeMessage: TybeMessage.positive);
          }
        }

        if (state is SendEmailVerificationErrorState) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          toastMessage(
            message: state.message.toString(),
            tybeMessage: TybeMessage.negative,
          );
        }

        if (state is VerifyResetCodeSuccessState) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          if (state.isVerified) {
            Navigator.pushNamed(
              context,
              RouteManager.resetPasswordScreen,
              arguments: email,
            );
          }
        }

        if (state is VerifyResetCodeErrorState) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          toastMessage(
            message: state.message.toString(),
            tybeMessage: TybeMessage.negative,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.password),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Config.screenHight! * 0.03),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.emailVerification,
                  style: AppTextStyle.medium20
                      .copyWith(color: ColorManager.blackBase),
                ),
              ),
              SizedBox(height: Config.screenHight! * 0.012),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.sendedCode,
                  textAlign: TextAlign.center,
                  style:
                  AppTextStyle.regular14.copyWith(color: ColorManager.grey),
                ),
              ),
              SizedBox(height: Config.screenHight! * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.white,
                    ),
                  ),
                  onCompleted: (value) {
                    if (value.length == 6) {
                      AuthCubit.get(context)
                          .doIntent(VerifyResetCode(resetCode: value));
                    }
                  },
                ),
              ),
              SizedBox(height: Config.screenHight! * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.dontRecieveCode,
                    style: AppTextStyle.regular16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: isResendEnabled
                          ? () {
                        setState(() {
                          isResendEnabled = false;
                          endTime = DateTime.now()
                              .add(const Duration(seconds: 60));
                        });

                        AuthCubit.get(context).doIntent(
                          ForgetPassword(email: email),
                        );
                      }
                          : null,
                      child: Text(AppStrings.resend,
                          style: AppTextStyle.regular16.copyWith(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: Theme.of(context).primaryColor,
                            decorationThickness: 2,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerCountdown(
                    colonsTextStyle: AppTextStyle.regular12
                        .copyWith(color: ColorManager.grey),
                    timeTextStyle: AppTextStyle.regular12
                        .copyWith(color: ColorManager.grey),
                    format: CountDownTimerFormat.secondsOnly,
                    endTime: endTime,
                    onEnd: () {
                      setState(() {
                        isResendEnabled = true;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
