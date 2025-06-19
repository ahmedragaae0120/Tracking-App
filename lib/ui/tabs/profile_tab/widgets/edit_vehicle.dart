import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/di/di.dart';
import '../../../../core/resuable_comp/custom_text_field.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../domain/entity/vehicle/getallvehicle_entity.dart';
import '../../../../domain/entity/vehicle/update_vehicle_entity.dart';
import '../../../Auth/view_model/cubit/auth_intent.dart';

class EditVehicle extends StatefulWidget {
  EditVehicle({super.key});

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  String selectedVehicleType = "";
  final vehicleLicenseController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  List<VehiclesEntity> vehicleTypes = [];
  AuthCubit authCubit = getIt<AuthCubit>();

  @override
  void initState() {
    super.initState();
    authCubit.getallvehicle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('${AppStrings.editProfile}'),
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
            if (state is applyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is getVehiclesSuccess) {
              vehicleTypes = state.vehicles.vehicles ?? [];

              vehicleTypes.forEach((v) => print("${v.id} - ${v.type}"));

              if (vehicleTypes.isNotEmpty && selectedVehicleType.isEmpty) {
                selectedVehicleType = vehicleTypes.first.id ?? '';
              }
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      label:  Text(AppStrings.vehicleType??""),
                    ),
                    value: selectedVehicleType.isNotEmpty &&
                        vehicleTypes.any((v) => v.id == selectedVehicleType)
                        ? selectedVehicleType
                        : null,
                    items: vehicleTypes.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.id ?? "",
                        child: Text(e.type ?? ''),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedVehicleType = val ?? "";
                      });
                    },
                  ),
                  const SizedBox(height: 20),
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
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                    authCubit.doIntent(updateVehicleIntent(
                  updateVehicleRequest: UpdateVehicleRequest(vehicleId: vehicleNumberController.text, licenseFile: authCubit.vehicleLicenseFile!

                  )
                    ));
                    },
                    child:  Text('update',style: AppTheme.lightTheme.textTheme.labelLarge,),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
