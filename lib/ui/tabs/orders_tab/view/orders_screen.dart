import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/resuable_comp/custom_order_card.dart';
import 'package:tracking_app/ui/tabs/orders_tab/view/widgets/custom_status_card.dart';
import 'package:tracking_app/ui/tabs/orders_tab/view_model/orders_cubit.dart';
import 'package:tracking_app/ui/tabs/orders_tab/view_model/orders_intent.dart';

import '../../../../core/di/di.dart';
import 'order_details.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrdersCubit _ordersCubit;

  @override
  void initState() {
    super.initState();
    _ordersCubit = getIt<OrdersCubit>();
    _ordersCubit.doIntent(GetDriverOrdersIntent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _ordersCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.arrow_back_ios),
              Text('My orders'),
            ],
          ),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is GetDriverOrdersLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetDriverOrdersErrorState) {
              return Center(child: Text(state.message));
            } else if (state is GetDriverOrdersSuccessState) {
              final completedOrders = state.orders
                  .where((o) => (o.order.state ?? '').toLowerCase() == 'completed')
                  .toList();
              final cancelledOrders = state.orders
                  .where((o) => (o.order.state ?? '').toLowerCase() == 'canceled')
                  .toList();
              final filteredOrders = [...completedOrders, ...cancelledOrders];

              // if (filteredOrders.isEmpty) {
              //   return const Center(child: Text('لا توجد طلبات مكتملة أو ملغاة'));
              // }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomStatusCard(
                          'Cancelled',
                          cancelledOrders.length,
                          Colors.red,
                          Icons.cancel_outlined,
                        ),
                        const SizedBox(width: 8),
                        CustomStatusCard(
                          'Completed',
                          completedOrders.length,
                          Colors.green,
                          Icons.check_circle_outline_outlined,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Recent orders",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredOrders.length ,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: CustomOrderCard(order: order,onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                  order: order,
                                ),
                              ),
                            );
                          },),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
