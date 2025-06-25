import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/resuable_comp/custom_text_field.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../domain/entity/vehicle/update_vehicle_entity.dart';
import '../../../Auth/view_model/cubit/auth_intent.dart';

class EditVehicle extends StatefulWidget {
  const EditVehicle({super.key});

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  final vehicleLicenseController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  late AuthCubit authCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authCubit = AuthCubit.get(context);
    authCubit.getallvehicle();
    final driver = authCubit.driver;
    vehicleNumberController.text = driver?.vehicleNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(AppStrings.editProfile),
        actions: [
          const Icon(
            Icons.notifications_none,
            size: 30,
          ),
        ],
      ),
      body: BlocProvider.value(
        value: authCubit,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is UpdateVehicleLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UpdateVehicleErrorState) {
              toastMessage(
                  message: state.message.toString(),
                  tybeMessage: TybeMessage.negative);
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.vehicleNumberCannotBeEmpty;
                        }
                        return null;
                      },
                      labelText: AppStrings.vehicleNumber,
                      controller: vehicleNumberController,
                      hintText: AppStrings.enterVehicleNumber,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.vehicleLicenseCannotBeEmpty;
                        }
                        return null;
                      },
                      labelText: AppStrings.vehicleLicense,
                      controller: vehicleLicenseController,
                      hintText: AppStrings.uploadlicense,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          await authCubit.pickVehicleLicense();
                          if (authCubit.vehicleLicenseFile != null) {
                            vehicleLicenseController.text = authCubit
                                .vehicleLicenseFile!.path
                                .split('/')
                                .last;
                          }
                          setState(() {});
                        },
                        icon: const Icon(Icons.upload),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authCubit.doIntent(updateVehicleIntent(
                              updateVehicleRequest: UpdateVehicleRequest(
                                  vehicleId:
                                      authCubit.driver?.vehicleType ?? "",
                                  licenseFile: authCubit.vehicleLicenseFile!)));
                        }
                      },
                      child: Text(
                        'update',
                        style: AppTheme.lightTheme.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
