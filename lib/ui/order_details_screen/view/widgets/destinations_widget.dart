import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationsWidget extends StatelessWidget {
  String imageUrl;
  String name;
  String phone;
  String subTitle;

  DestinationsWidget({
    required this.name,
    required this.phone,
    required this.subTitle,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
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
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Name and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.regular12
                              .copyWith(color: ColorManager.grey),
                        ),
                        Text(
                          subTitle,
                          overflow: TextOverflow.clip,
                          style: AppTextStyle.regular14.copyWith(
                              color: ColorManager.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  // Buttons
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(phone);
                        },
                        icon: SvgPicture.asset(
                          'assets/images/call.svg',
                        ),
                        color: ColorManager.pink,
                      ),
                      IconButton(
                        onPressed: () async {
                          final phoneWithoutPlus =
                              phone.replaceAll('+', '').replaceAll(' ', '');
                          final url = 'https://wa.me/$phoneWithoutPlus';

                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          } else {
                            toastMessage(
                                message: AppStrings.whatsAppcannotbeopened,
                                tybeMessage: TybeMessage.negative);

                            print('Could not launch $url');
                          }
                        },
                        icon: SvgPicture.asset(
                          'assets/images/whatsapp.svg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
