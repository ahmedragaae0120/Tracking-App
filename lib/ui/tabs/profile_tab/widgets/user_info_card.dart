import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';

class UserInfoCard extends StatelessWidget {
  final VoidCallback onTap;

  const UserInfoCard({super.key,required this.onTap});

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
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: driver?.photo ?? "",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20), // spacing بدل من 'spacing' اللي غلط
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driver?.firstName ?? "",
                            style: AppTextStyle.medium18,
                          ),
                          Text(
                            driver?.email ?? "",
                            style: AppTextStyle.regular16,
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            driver?.phone ?? "",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
