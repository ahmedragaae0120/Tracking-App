import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/core/resuable_comp/text_button.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/core/utils/config.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:tracking_app/ui/map/view/cubit/map_cubit.dart';
import 'package:tracking_app/ui/map/view/cubit/map_intent.dart';
import 'package:tracking_app/ui/order_details_screen/view/order_details_scroll_part.dart';
import 'package:tracking_app/ui/order_details_screen/view_model/cubit/order_details_cubit.dart';
import 'package:tracking_app/ui/order_details_screen/view_model/cubit/oreder_datails_intent.dart';
import 'package:tracking_app/ui/success_page/view/success_page.dart';

class OrderBottomSheet extends StatelessWidget {
  final Orders order;
  final OrderStatus? statusName;
  final DraggableScrollableController controller;
  final LatLng latLongHome;
  final LatLng latLongShop;
  final Function(OrderStatus newStatus) onStatusChange;

  const OrderBottomSheet({
    super.key,
    required this.order,
    required this.statusName,
    required this.controller,
    required this.latLongHome,
    required this.latLongShop,
    required this.onStatusChange,
  });

  bool isBackEnabled(OrderStatus? status) {
    return status != OrderStatus.receivedYourOrder;
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

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderDetailsCubit>();
    final mapCubit = context.read<MapCubit>();

    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0.9,
      minChildSize: 0.2,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: Config.screenWidth! * 0.2,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: BlocListener<OrderDetailsCubit, OrderDetailsState>(
                  listener: (context, state) {
                    if (state is UpdateOrderStatusApiSuccessState) {
                      toastMessage(
                        message: AppStrings.orderDeliveredSuccessfully,
                        tybeMessage: TybeMessage.positive,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SuccessPage(),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: StepProgressIndicator(
                                padding: 4,
                                totalSteps: 4,
                                currentStep: statusName != null
                                    ? getStepNumberFromStatus(statusName!)
                                    : 1,
                                selectedColor: ColorManager.green,
                                unselectedColor: ColorManager.white70,
                              ),
                            ),
                            Expanded(
                              child: OrderDetailsScrollPart(
                                order: order,
                                scrollController: scrollController,
                                statusName: statusName,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: isBackEnabled(statusName)
                                          ? () {
                                              switch (statusName) {
                                                case OrderStatus
                                                      .preparingYourOrder:
                                                  cubit.doIntent(
                                                      UpdateOrderStatusIntent(
                                                    isDone: false,
                                                    orderId: order.id ?? "",
                                                    statusName: OrderStatus
                                                        .receivedYourOrder,
                                                  ));
                                                  onStatusChange(OrderStatus
                                                      .receivedYourOrder);
                                                  break;

                                                case OrderStatus.outForDelivery:
                                                  cubit.doIntent(
                                                      UpdateOrderStatusIntent(
                                                    isDone: false,
                                                    orderId: order.id ?? "",
                                                    statusName: OrderStatus
                                                        .preparingYourOrder,
                                                  ));
                                                  mapCubit.doIntent(
                                                    AddDestinationMarker(
                                                      latLong: latLongShop,
                                                      isHome: false,
                                                    ),
                                                  );
                                                  onStatusChange(OrderStatus
                                                      .preparingYourOrder);
                                                  break;

                                                case OrderStatus.delivered:
                                                  cubit.doIntent(
                                                      UpdateOrderStatusIntent(
                                                    isDone: false,
                                                    orderId: order.id ?? "",
                                                    statusName: OrderStatus
                                                        .outForDelivery,
                                                  ));
                                                  onStatusChange(OrderStatus
                                                      .outForDelivery);
                                                  break;

                                                default:
                                                  toastMessage(
                                                    message: AppStrings
                                                        .youCanNotGoBack,
                                                    tybeMessage:
                                                        TybeMessage.negative,
                                                  );
                                                  break;
                                              }
                                            }
                                          : null,
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: isBackEnabled(statusName)
                                              ? ColorManager.pink
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                            color: ColorManager.pink,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_rounded,
                                          color: isBackEnabled(statusName)
                                              ? Colors.white
                                              : ColorManager.pink,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 3,
                                    child: CustomTextButton(
                                      onPressed: () {
                                        switch (statusName) {
                                          case OrderStatus.receivedYourOrder:
                                            cubit.doIntent(
                                                UpdateOrderStatusIntent(
                                              isDone: true,
                                              orderId: order.id ?? "",
                                              statusName:
                                                  OrderStatus.receivedYourOrder,
                                            ));
                                            onStatusChange(
                                                OrderStatus.preparingYourOrder);
                                            break;

                                          case OrderStatus.preparingYourOrder:
                                            cubit.doIntent(
                                                UpdateOrderStatusIntent(
                                              isDone: true,
                                              orderId: order.id ?? "",
                                              statusName: OrderStatus
                                                  .preparingYourOrder,
                                            ));
                                            mapCubit
                                                .doIntent(AddDestinationMarker(
                                              latLong: latLongHome,
                                              isHome: true,
                                            ));
                                            onStatusChange(
                                                OrderStatus.outForDelivery);
                                            break;

                                          case OrderStatus.outForDelivery:
                                            cubit.doIntent(
                                                UpdateOrderStatusIntent(
                                              isDone: true,
                                              orderId: order.id ?? "",
                                              statusName:
                                                  OrderStatus.outForDelivery,
                                            ));
                                            onStatusChange(
                                                OrderStatus.delivered);
                                            break;

                                          case OrderStatus.delivered:
                                            cubit.doIntent(
                                                UpdateOrderStatusIntent(
                                              isDone: true,
                                              orderId: order.id ?? "",
                                              statusName: OrderStatus.delivered,
                                            ));
                                            cubit.doIntent(
                                                UpdateOrderStatusApiIntent(
                                              orderId: order.id ?? "",
                                            ));
                                            break;

                                          default:
                                            onStatusChange(
                                                OrderStatus.receivedYourOrder);
                                        }
                                      },
                                      borderColor: ColorManager.pink,
                                      text: getButtonState(statusName!),
                                      color: ColorManager.pink,
                                      textColor: ColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
