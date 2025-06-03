import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';

class VehicleInfoCard extends StatelessWidget {
  final VoidCallback? onTap;

  const VehicleInfoCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Driver? driver = AuthCubit.get(context).driver;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.vehicleInfo,
                      style: AppTextStyle.medium18,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      driver?.vehicleType ?? "",
                      style: AppTextStyle.regular16,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      driver?.vehicleNumber ?? "",
                      style: AppTextStyle.regular16,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorManager.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
