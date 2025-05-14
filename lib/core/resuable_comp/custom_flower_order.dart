// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tracking_app/data/model/orders/orders.dart';

import '../../ui/tabs/home_tab/view/widgets/address_card.dart';
import '../utils/colors_manager.dart';

class CustomFlowerOrder extends StatelessWidget {
  final String price;
  final Orders order;
  final Function(String) onReject;
  final Function(String) onAccept;

  const CustomFlowerOrder({
    super.key,
    required this.price,
    required this.order,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                '${order.user?.firstName ?? ''} ${order.user?.lastName ?? ''}',
            address: order.user?.phone ?? '20th st, Sheikh Zayed, Giza',
          ),
          Row(
            children: [
              Text(
                "EGP $price",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    onReject(order.id ?? '');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorManager.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Reject",
                    style: TextStyle(color: ColorManager.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    onAccept(order.id ?? '');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
