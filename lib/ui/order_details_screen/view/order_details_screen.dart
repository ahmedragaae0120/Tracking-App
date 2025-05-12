import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/core/resuable_comp/text_button.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/core/utils/text_style_manager.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/destinations_widget.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/order_details_card.dart';
import 'package:tracking_app/ui/order_details_screen/view/widgets/product_summary_card.dart';
import 'package:tracking_app/ui/order_details_screen/view_model/cubit/order_details_cubit.dart';
import 'package:tracking_app/ui/order_details_screen/view_model/cubit/oreder_datails_intent.dart';
import 'widgets/payment_card.dart';

class OrderDetailsScreen extends StatefulWidget {
  Orders order;

  OrderStatus? statusName = OrderStatus.receivedYourOrder;

  OrderDetailsScreen({required this.order, super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.order.state == Constant.canceledKey ||
          widget.order.state == Constant.completedKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: widget.order.state == Constant.canceledKey ||
              widget.order.state == Constant.completedKey,
          title: Text(AppStrings.orderDetails),
        ),
        body: BlocProvider(
          create: (context) => getIt<OrderDetailsCubit>()
            ..doIntent(UpdateDriverInfoIntent(
                orderId: widget.order.id ?? "",
                name: AuthCubit.get(context).driver?.firstName ?? "",
                phone: AuthCubit.get(context).driver?.phone ?? "",
                driverId: AuthCubit.get(context).driver?.id ?? "",
                driverStatus: DriverStatus.accept)),
          child: BlocListener<OrderDetailsCubit, OrderDetailsState>(
            listener: (context, state) {
              if (state is UpdateOrderStatusApiSuccessState) {
                toastMessage(
                    message: AppStrings.orderDeliveredSuccessfully,
                    tybeMessage: TybeMessage.positive);
                Navigator.pop(context);
              }
            },
            child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
              builder: (context, state) {
                final cubit = context.read<OrderDetailsCubit>();
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: StepProgressIndicator(
                          padding: 4,
                          totalSteps: 4,
                          currentStep: widget.statusName != null
                              ? getStepNumberFromStatus(widget.statusName!)
                              : 1,
                          selectedColor: ColorManager.green,
                          unselectedColor: ColorManager.white70,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                widget.order.state != Constant.canceledKey &&
                                        widget.order.state !=
                                            Constant.completedKey
                                    ? OrderDetailsCard(
                                        status: getState(widget.statusName ??
                                            OrderStatus.receivedYourOrder),
                                        orderId: widget.order.id ?? "",
                                        date: widget.order.createdAt ?? "",
                                      )
                                    : Row(
                                        children: [
                                          Icon(
                                            widget.order.state ==
                                                    Constant.completedKey
                                                ? Icons
                                                    .check_circle_outline_outlined
                                                : Icons.cancel_outlined,
                                            color: widget.order.state ==
                                                    Constant.completedKey
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            widget.order.state ?? "",
                                            style: TextStyle(
                                              color: widget.order.state ==
                                                      Constant.completedKey
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          const SizedBox(width: 16),
                                          FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child:
                                                  Text(widget.order.id ?? "")),
                                        ],
                                      ),
                                Text(
                                  AppStrings.pickupAddress,
                                  style: AppTextStyle.regular16
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                DestinationsWidget(
                                  imageUrl: widget.order.store?.image ?? "",
                                  name: widget.order.store?.name ?? "",
                                  phone: widget.order.store?.phoneNumber ?? "",
                                  subTitle: widget.order.store?.address ?? "",
                                ),
                                Text(
                                  AppStrings.userAddress,
                                  style: AppTextStyle.regular16
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                DestinationsWidget(
                                  imageUrl: widget.order.user?.photo ?? "",
                                  name: widget.order.user?.firstName ?? "",
                                  phone: widget.order.user?.phone ?? "",
                                  subTitle: widget.order.user?.email ?? "",
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
                                      widget.order.orderItems?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return ProductSummaryCard(
                                      orderItem:
                                          widget.order.orderItems![index],
                                    );
                                  },
                                ),
                                PaymentCard(
                                  lable: AppStrings.total,
                                  value:
                                      " EGP ${widget.order.totalPrice.toString()}",
                                ),
                                PaymentCard(
                                  lable: AppStrings.paymentMethod,
                                  value: widget.order.paymentType ?? "",
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (widget.order.state != Constant.canceledKey &&
                          widget.order.state != Constant.completedKey)
                        CustomTextButton(
                          onPressed: () {
                            setState(() {
                              switch (widget.statusName) {
                                case OrderStatus.receivedYourOrder:
                                  cubit.doIntent(UpdateOrderStatusIntent(
                                      isDone: false,
                                      orderId: widget.order.id ?? "",
                                      statusName:
                                          OrderStatus.receivedYourOrder));
                                  widget.statusName =
                                      OrderStatus.preparingYourOrder;
                                  break;
                                case OrderStatus.preparingYourOrder:
                                  cubit.doIntent(UpdateOrderStatusIntent(
                                      isDone: false,
                                      orderId: widget.order.id ?? "",
                                      statusName:
                                          OrderStatus.preparingYourOrder));
                                  widget.statusName =
                                      OrderStatus.outForDelivery;
                                  break;
                                case OrderStatus.outForDelivery:
                                  cubit.doIntent(UpdateOrderStatusIntent(
                                      isDone: false,
                                      orderId: widget.order.id ?? "",
                                      statusName: OrderStatus.outForDelivery));
                                  widget.statusName = OrderStatus.delivered;
                                  break;
                                case OrderStatus.delivered:
                                  cubit.doIntent(UpdateOrderStatusIntent(
                                      isDone: true,
                                      orderId: widget.order.id ?? "",
                                      statusName:
                                          OrderStatus.preparingYourOrder));
                                  cubit.doIntent(UpdateOrderStatusApiIntent(
                                    orderId: widget.order.id ?? "",
                                  ));
                                  break;
                                default:
                                  widget.statusName =
                                      OrderStatus.receivedYourOrder;
                              }
                            });
                          },
                          borderColor: ColorManager.pink,
                          text: getButtonState(widget.statusName ??
                              OrderStatus.receivedYourOrder),
                          color: ColorManager.pink,
                          textColor: ColorManager.white,
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  int getStepNumberFromStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.receivedYourOrder:
        return 1;
      case OrderStatus.preparingYourOrder:
        return 2;
      case OrderStatus.outForDelivery:
        return 3;
      case OrderStatus.delivered:
        return 4;
    }
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

  String getButtonState(OrderStatus status) {
    switch (status) {
      case OrderStatus.receivedYourOrder:
        return AppStrings.arrivedAtPickupPoint;
      case OrderStatus.preparingYourOrder:
        return AppStrings.startDeliver;
      case OrderStatus.outForDelivery:
        return AppStrings.outForDelivery;
      case OrderStatus.delivered:
        return AppStrings.delivered;
    }
  }
}
