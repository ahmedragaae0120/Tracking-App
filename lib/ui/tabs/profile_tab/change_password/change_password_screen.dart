import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/resuable_comp/custom_text_field.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'cubit/change_password_cubit.dart';
import 'cubit/change_password_intent.dart';
import 'cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          toastMessage(
            message: state.message,
            tybeMessage: TybeMessage.positive,
          );
          Navigator.pop(context);
        } else if (state is ChangePasswordFailure) {
          toastMessage(
            message: state.message,
            tybeMessage: TybeMessage.negative,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            AppStrings.resetPassword,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: currentPasswordController,
                  labelText: AppStrings.currentPassword,
                  hintText: AppStrings.enterYourPassword,
                  obscureText: true,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: newPasswordController,
                  labelText: AppStrings.newPassword,
                  hintText: AppStrings.enterYourNewPassword,
                  obscureText: true,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: confirmPasswordController,
                  labelText: AppStrings.confirmPassword,
                  hintText: AppStrings.confirmPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty == true) return 'Required';
                    if (value != newPasswordController.text) {
                      return AppStrings.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is ChangePasswordLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ChangePasswordCubit>().onIntent(
                                        ChangePasswordRequestIntent(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        ),
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE91E63),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: state is ChangePasswordLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                AppStrings.update,
                                style: const TextStyle(color: Colors.white),
                              ),
                      );
                    },
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
