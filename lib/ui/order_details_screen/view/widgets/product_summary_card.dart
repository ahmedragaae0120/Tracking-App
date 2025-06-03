// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/data/model/orders/order_items.dart';

class ProductSummaryCard extends StatelessWidget {
  OrderItems orderItem;
  ProductSummaryCard({required this.orderItem, super.key});

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
                  imageUrl: orderItem.product?.images?.first ?? "",
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                orderItem.product?.title ?? "",
                                overflow: TextOverflow.clip,
                                style: AppTextStyle.regular12
                                    .copyWith(color: ColorManager.grey),
                              ),
                            ),
                            Text(
                              "X ${orderItem.quantity}",
                              style: TextStyle(color: ColorManager.pink),
                            ),
                          ],
                        ),
                        Text(
                          "EGP ${orderItem.product?.price?.toString() ?? "0"}",
                          overflow: TextOverflow.clip,
                          style: AppTextStyle.regular14.copyWith(
                              color: ColorManager.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
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
