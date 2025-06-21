// Import for File
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/resuable_comp/validator.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_intent.dart';

import '../../../config/theme/app_theme.dart';
import '../../../core/resuable_comp/custom_text_field.dart';
import '../../../core/resuable_comp/toast_message.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../../../domain/entity/auth/apply_request.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  List<dynamic> countries = [];
  List<VehiclesEntity> vehicleTypes = [];
  String? selectedCountry;
  String selectedGender = AppStrings.female;
  String selectedVehicleType = AppStrings.cars;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final vehicleLicenseController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final idNumberController = TextEditingController();
  final idImageController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthCubit authCubit = getIt<AuthCubit>();

  @override
  void initState() {
    super.initState();
    authCubit.getallvehicle();
    authCubit.loadCountries();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    vehicleNumberController.dispose();
    vehicleLicenseController.dispose();
    emailController.dispose();
    phoneController.dispose();
    idNumberController.dispose();
    idImageController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        title: Text(AppStrings.apply),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, state) {
          if (state is applySuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, RouteManager.applySuccess);
            });
          }
          if (state is LoadContrySuccess) {
            countries = state.countries;
          } else if (state is applyFailure) {
            toastMessage(
                message: state.message, tybeMessage: TybeMessage.negative);
          } else if (state is applyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is getVehiclesSuccess) {
            vehicleTypes = state.vehicles.vehicles ?? [];
            if (vehicleTypes.isNotEmpty) {
              selectedVehicleType = selectedVehicleType.isEmpty
                  ? vehicleTypes.first.id ?? ''
                  : selectedVehicleType;
            }
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.welcome,
                  style: TextStyle(
                    fontSize:
                        AppTheme.lightTheme.textTheme.titleLarge?.fontSize,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  AppStrings.youWantToBeaDeliveryMan,
                  style: TextStyle(
                    fontSize: AppTheme.lightTheme.textTheme.bodyLarge?.fontSize,
                  ),
                ),
                Text(
                  AppStrings.joinOurTeam,
                  style: TextStyle(
                    fontSize: AppTheme.lightTheme.textTheme.bodyLarge?.fontSize,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.none,
                        width: 4,
                        color: Colors.black,
                      ),
                    ),
                    labelStyle: AppTextStyle.regular14,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    label: Text(AppStrings.country),
                  ),
                  style: Theme.of(context).textTheme.labelMedium,
                  hint: Text(
                    AppStrings.selectCountry,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  value: countries.any((c) => c['name'] == selectedCountry)
                      ? selectedCountry
                      : null,
                  items: countries.map((e) {
                    return DropdownMenuItem<String>(
                      value: e['name'] ?? "error",
                      child: Row(
                        children: [
                          Text(
                            e['flag'] ?? "🏳️",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            e['name'] ?? "error",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCountry = val ?? '';
                    });
                  },
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  validator: Validator.firstName,
                  labelText: AppStrings.firstLegalName,
                  controller: firstNameController,
                  hintText: AppStrings.enterFirstLegalName,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  validator: Validator.lastName,
                  labelText: AppStrings.secondLegalName,
                  controller: lastNameController,
                  hintText: AppStrings.enterSecondLegalName,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.none,
                        width: 4,
                        color: Colors.black,
                      ),
                    ),
                    labelStyle: AppTextStyle.regular14,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    label: Text(AppStrings.vehicleType),
                  ),
                  style: Theme.of(context).textTheme.labelMedium,
                  hint: Text(
                    AppStrings.selectVehicleType,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  value: selectedVehicleType.isNotEmpty &&
                          vehicleTypes.any((v) => v.id == selectedVehicleType)
                      ? selectedVehicleType
                      : null,
                  items: vehicleTypes.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.id ?? "error",
                      child: Text(
                        e.type ?? '',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedVehicleType = val ?? AppStrings.cars;
                    });
                  },
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  labelText: AppStrings.vehicleNumber,
                  controller: vehicleNumberController,
                  hintText: AppStrings.enterVehicleNumber,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: AppStrings.vehicleLicense,
                  controller: vehicleLicenseController,
                  hintText: AppStrings.uploadlicense,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await authCubit.pickVehicleLicense();
                      if (authCubit.vehicleLicenseFile != null) {
                        vehicleLicenseController.text =
                            authCubit.vehicleLicenseFile!.path.split('/').last;
                      }
                      setState(() {});
                    },
                    icon: const Icon(Icons.upload),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: AppStrings.email,
                  controller: emailController,
                  hintText: AppStrings.enterEmail,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: AppStrings.phoneNumber,
                  controller: phoneController,
                  hintText: AppStrings.enterPhoneNumber,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: AppStrings.idNumber,
                  controller: idNumberController,
                  hintText: AppStrings.enterIDNumber,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: AppStrings.idImage,
                  controller: idImageController,
                  hintText: AppStrings.uploadidimage,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await authCubit.pickNidImage();
                      if (authCubit.nidImageFile != null) {
                        idImageController.text =
                            authCubit.nidImageFile!.path.split('/').last;
                      }
                      setState(() {});
                    },
                    icon: const Icon(Icons.upload),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        validator: Validator.password,
                        labelText: AppStrings.password,
                        controller: passwordController,
                        hintText: AppStrings.enterPassword,
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        validator: (value) => Validator.confirmPassword(
                            value, passwordController.text),
                        labelText: AppStrings.confirmPassword,
                        controller: confirmPasswordController,
                        hintText: AppStrings.enterConfirmPassword,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      AppStrings.gender,
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.male,
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                    Radio<String>(
                      value: 'male',
                      groupValue: selectedGender,
                      onChanged: (val) {
                        setState(() {
                          if (val != null) selectedGender = val;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.female,
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                    Radio<String>(
                      value: 'female',
                      groupValue: selectedGender,
                      onChanged: (val) {
                        setState(() {
                          if (val != null) selectedGender = val;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: AppTheme.lightTheme.elevatedButtonTheme.style,
                  onPressed: () async {
                    final request = applyrequest(
                      country: selectedCountry ?? '',
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      vehicleType: selectedVehicleType,
                      vehicleNumber: vehicleNumberController.text,
                      vehicleLicense: authCubit.vehicleLicenseFile!,
                      nid: idNumberController.text,
                      nidImg: authCubit.nidImageFile!,
                      email: emailController.text,
                      gender: selectedGender,
                      phone: phoneController.text,
                      password: passwordController.text,
                      rePassword: confirmPasswordController.text,
                    );

                    authCubit.doIntent(applyIntent(request: request));
                  },
                  child: Text(
                    AppStrings.continueText,
                    style: AppTheme.lightTheme.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
