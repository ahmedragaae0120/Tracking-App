// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  void Function()? onpressed;
  String title;
  AppBarWidget({super.key, required this.onpressed, required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onpressed,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 25,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
