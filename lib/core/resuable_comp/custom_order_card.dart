// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tracking_app/data/model/orders/driver_order.dart';
import 'package:tracking_app/data/model/orders/orders.dart';

import '../../ui/tabs/home_tab/view/widgets/address_card.dart';
import '../utils/colors_manager.dart';

class CustomOrderCard extends StatelessWidget {
  final DriverOrder order;
  final void Function()? onTap;

  const CustomOrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ColorManager.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Flower order",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    order.order.state == "canceled" ? Icon(Icons.cancel_outlined,color: Colors.red,) : Icon(Icons.check_circle_outline_outlined,color: Colors.green,),
                    SizedBox(width: 10,),
                    order.order.state == "canceled" ? Text("Canceled",style: TextStyle(color: Colors.red),) : Text("Completed",style: TextStyle(color: Colors.green),),
                  ],
                ),
                Text("${order.order.orderNumber}"),
              ],
            ),
            const SizedBox(height: 5),
            AddressCard(
              title: "Pickup address",
              image: order.store?.image ??
                  'https://img.icons8.com/color/48/flower.png',
              subtitle: order.store?.name ?? 'Flowery store',
              address: order.store?.address ?? '20th st, Sheikh Zayed, Giza',
            ),
            AddressCard(
              title: "User address",
              image: 'https://randomuser.me/api/portraits/women/44.jpg',
              subtitle:
              '${order.order.user?.firstName ?? ''} ${order.order.user?.lastName ?? ''}',
              address: order.order.user?.phone ?? '20th st, Sheikh Zayed, Giza',
            ),
          ],
        ),
      ),
    );
  }
}
