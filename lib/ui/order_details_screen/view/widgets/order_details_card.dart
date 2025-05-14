// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

import 'package:intl/intl.dart';
import 'package:tracking_app/core/utils/string_manager.dart';

class OrderDetailsCard extends StatelessWidget {
  final String status;
  final String date;
  final String orderId;

  OrderDetailsCard({
    required this.status,
    required this.date,
    required this.orderId,
    super.key,
  });

  String formatDate(String isoDate) {
    try {
      final dateTime =
          DateTime.parse(isoDate).toLocal(); // Convert to local time
      final formatter = DateFormat('EEE, dd MMM yyyy, hh:mm a');
      return formatter.format(dateTime);
    } catch (e) {
      return isoDate; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.lightPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppStrings.status}: $status",
              style: TextStyle(color: ColorManager.green),
            ),
            Text("${AppStrings.orderId}: $orderId",
                style: TextStyle(color: ColorManager.black)),
            Text("${AppStrings.date}: ${formatDate(date)}",
                style: TextStyle(color: ColorManager.white80)),
          ],
        ),
      ),
    );
  }
}
