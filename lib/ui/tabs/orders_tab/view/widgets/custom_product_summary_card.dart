import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/data/model/orders/order_items.dart';
import 'package:tracking_app/ui/tabs/orders_tab/view_model/orders_cubit.dart';
import 'package:tracking_app/ui/tabs/orders_tab/view_model/orders_intent.dart';

import '../../../../../data/model/orders/product.dart';

class CustomProductSummaryCard extends StatefulWidget {
  final OrderItems orderItem;
  const CustomProductSummaryCard({required this.orderItem, super.key});

  @override
  State<CustomProductSummaryCard> createState() => _CustomProductSummaryCardState();
}

class _CustomProductSummaryCardState extends State<CustomProductSummaryCard> {
  Product? _loadedProduct;

  @override
  void initState() {
    super.initState();
    final productId = widget.orderItem.product?.id;
    if (productId != null) {
      final cubit = context.read<OrdersCubit>();
      cubit.doIntent(GetSpecificProductIntent(productId: productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is GetSpecificProductSuccessState) {
          if (state.product.id == widget.orderItem.product?.id) {
            setState(() {
              _loadedProduct = state.product;
            });
          }
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: (_loadedProduct?.images?.isNotEmpty == true)
                        ? _loadedProduct!.images!.first
                        : (widget.orderItem.product?.images?.isNotEmpty == true
                        ? widget.orderItem.product!.images!.first
                        : "https://flower.elevateegy.com/uploads/66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png"),
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
                    errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error, color: Colors.red)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _loadedProduct?.title ??
                                widget.orderItem.product?.title ??
                                "Loading...",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyle.regular12
                                .copyWith(color: ColorManager.grey),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "X ${widget.orderItem.quantity}",
                          style: TextStyle(color: ColorManager.pink),
                        ),
                      ],
                    ),
                    Text(
                      "EGP ${_loadedProduct?.price?.toString() ?? widget.orderItem.product?.price?.toString() ?? "0"}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyle.regular14.copyWith(
                          color: ColorManager.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
