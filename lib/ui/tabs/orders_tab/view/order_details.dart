// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/destinations_widget.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/product_summary_card.dart';
import 'package:tracking_app/ui/tabs/orders_tab/view/widgets/custom_product_summary_card.dart';
import '../../../../data/model/orders/driver_order.dart';
import '../../../order_details_screen/view/widgets/payment_card.dart';
import '../view_model/orders_cubit.dart';

class OrderDetails extends StatelessWidget {
  DriverOrder order;


  OrderDetails({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(AppStrings.orderDetails),
          ],
        ),
      ),
      body: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                             Row(
                                      children: [
                                        Icon(
                                          order.order.state ==
                                                  Constant.completedKey
                                              ? Icons
                                                  .check_circle_outline_outlined
                                              : Icons.cancel_outlined,
                                          color: order.order.state ==
                                                  Constant.completedKey
                                              ? Colors.green
                                              : Colors.red,
                                          size: 35,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          order.order.state == Constant.completedKey ? "Completed" : "Canceled",
                                          style: TextStyle(
                                            color: order.order.state ==
                                                    Constant.completedKey
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          ),
                                        ),
                                        Spacer(),
                                        const SizedBox(width: 16),
                                        FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child:
                                                Text(order.order.orderNumber ?? "")),
                                      ],
                                    ),
                              Text(
                                AppStrings.pickupAddress,
                                style: AppTextStyle.regular16
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              DestinationsWidget(
                                imageUrl: order.store.image ?? "",
                                name: order.store.name ?? "",
                                phone: order.store.phoneNumber ?? "",
                                subTitle: order.store.address ?? "",
                              ),
                              Text(
                                AppStrings.userAddress,
                                style: AppTextStyle.regular16
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              DestinationsWidget(
                                // imageUrl: order.order.user?.photo ?? 'https://randomuser.me/api/portraits/women/44.jpg',
                                imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
                                name: order.order.user?.firstName ?? "",
                                phone: order.order.user?.phone ?? "",
                                subTitle: order.order.user?.email ?? "",
                              ),
                              Text(
                                AppStrings.orderDetails,
                                style: AppTextStyle.regular16
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    order.order.orderItems?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return  BlocProvider<OrdersCubit>(
                                    create: (context) => getIt<OrdersCubit>(),
                                    child: CustomProductSummaryCard(
                                      orderItem:
                                          order.order.orderItems![index],
                                    ),
                                  );
                                },
                              ),
                              PaymentCard(
                                lable: AppStrings.total,
                                value:
                                    " EGP ${order.order.totalPrice.toString()}",
                              ),
                              PaymentCard(
                                lable: AppStrings.paymentMethod,
                                value: order.order.paymentType ?? "",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      )
    );
  }
}
