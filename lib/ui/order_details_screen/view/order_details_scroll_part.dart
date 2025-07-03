import 'package:flutter/material.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/destinations_widget.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/order_details_card.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/payment_card.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/product_summary_card.dart';

class OrderDetailsScrollPart extends StatelessWidget {
  final Orders order;
  final OrderStatus? statusName;
  final ScrollController scrollController;

  const OrderDetailsScrollPart(
      {required this.scrollController,
      required this.statusName,
      required this.order,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            OrderDetailsCard(
              status: getState(statusName ?? OrderStatus.receivedYourOrder),
              orderId: order.id ?? "",
              date: order.createdAt ?? "",
            ),
            Text(
              AppStrings.pickupAddress,
              style:
                  AppTextStyle.regular16.copyWith(fontWeight: FontWeight.bold),
            ),
            DestinationsWidget(
              imageUrl: order.store?.image ?? "",
              name: order.store?.name ?? "",
              phone: order.store?.phoneNumber ?? "",
              subTitle: order.store?.address ?? "",
            ),
            Text(
              AppStrings.userAddress,
              style:
                  AppTextStyle.regular16.copyWith(fontWeight: FontWeight.bold),
            ),
            DestinationsWidget(
              imageUrl: order.user?.photo ?? "",
              name: order.user?.firstName ?? "",
              phone: order.user?.phone ?? "",
              subTitle: order.user?.email ?? "",
            ),
            Text(
              AppStrings.orderDetails,
              style:
                  AppTextStyle.regular16.copyWith(fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.orderItems?.length ?? 0,
              itemBuilder: (context, index) {
                return ProductSummaryCard(
                  orderItem: order.orderItems![index],
                );
              },
            ),
            PaymentCard(
              lable: AppStrings.total,
              value: " EGP ${order.totalPrice.toString()}",
            ),
            PaymentCard(
              lable: AppStrings.paymentMethod,
              value: order.paymentType ?? "",
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  String getState(OrderStatus status) {
    switch (status) {
      case OrderStatus.receivedYourOrder:
        return AppStrings.accepted;
      case OrderStatus.preparingYourOrder:
        return AppStrings.picked;
      case OrderStatus.outForDelivery:
        return AppStrings.outForDelivery;
      case OrderStatus.delivered:
        return AppStrings.delivered;
    }
  }
}
