// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../../core/utils/colors_manager.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  final String address;

  const AddressCard({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: ColorManager.grey.withOpacity(0.7)),
        ),
        const SizedBox(height: 6),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ColorManager.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style:
                        const TextStyle(fontSize: 16, color: ColorManager.grey),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      const SizedBox(width: 2),
                      Text(
                        address,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
