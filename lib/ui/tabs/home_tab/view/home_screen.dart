// ignore_for_file: use_build_context_synchronously, prefer_is_not_operator

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resuable_comp/custom_flower_order.dart';
import '../../../../core/utils/colors_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/resuable_comp/custom_flower_order.dart';
import 'package:tracking_app/core/resuable_comp/search_bar/custom_searchbar_widget.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/ui/order_details_screen/view/order_details_screen.dart';
import 'package:tracking_app/ui/tabs/home_tab/view_model/home_cubit.dart';
import 'package:tracking_app/ui/tabs/home_tab/view_model/home_intent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _homeCubit = getIt<HomeCubit>();
    _homeCubit.doIntent(GetPendingOrdersIntent());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!(_homeCubit.state is GetPendingOrdersLoadingState)) {
        _homeCubit.doIntent(LoadMoreOrdersIntent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.pendingOrders),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            final cubit = context.read<HomeCubit>();

            if (state is StartOrderSuccessState) {
              // Find the order in filteredOrders instead of allOrders
              // or use firstWhere with orElse to prevent exceptions
              final selectedOrder = cubit.filteredOrders.firstWhere(
                (order) => order.id == state.orderId,
                orElse: () => cubit.allOrders.firstWhere(
                  (order) => order.id == state.orderId,
                  orElse: () => throw Exception("Order not found"),
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsScreen(
                    order: selectedOrder,
                  ),
                ),
              ).then((_) {
                context.read<HomeCubit>().doIntent(GetPendingOrdersIntent());
              });
            } else if (state is StartOrderErrorState) {
              toastMessage(
                  message: state.message, tybeMessage: TybeMessage.negative);
            } else if (state is GetPendingOrdersErrorState) {
              toastMessage(
                  message: state.message, tybeMessage: TybeMessage.negative);
            } else if (state is RejectOrderSuccessState) {
              toastMessage(
                  message: "Order rejected successfully",
                  tybeMessage: TybeMessage.positive);
            }
          },
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();

            return Column(
              children: [
                // Search Bar
                CustomSearchBar(
                  margin: const EdgeInsets.all(16),
                  readOnly: false,
                  onSubmitted: (query) {
                    cubit.doIntent(SearchOrdersIntent(query: query));
                  },
                ),

                // Orders List
                Expanded(
                  child: state is GetPendingOrdersLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: () async {
                            cubit.doIntent(GetPendingOrdersIntent());
                          },
                          child: cubit.filteredOrders.isEmpty
                              ? Center(
                                  child: Text(
                                    AppStrings.noOrdersAvailable,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: cubit.filteredOrders.length +
                                      1, // +1 for loading indicator
                                  itemBuilder: (context, index) {
                                    if (index < cubit.filteredOrders.length) {
                                      final order = cubit.filteredOrders[index];
                                      return CustomFlowerOrder(
                                        price:
                                            order.totalPrice?.toString() ?? "0",
                                        order: order,
                                        onReject: (id) {
                                          cubit.doIntent(
                                              RejectOrderIntent(orderId: id));
                                        },
                                        onAccept: (id) {
                                          cubit.doIntent(
                                              StartOrderIntent(orderId: id));
                                        },
                                      );
                                    } else {
                                      // Show loading indicator at the bottom
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: cubit.state
                                                  is GetPendingOrdersLoadingState
                                              ? const CircularProgressIndicator()
                                              : const SizedBox(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


