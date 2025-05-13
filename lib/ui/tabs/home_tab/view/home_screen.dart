import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/resuable_comp/custom_flower_order.dart';
import '../../../../core/utils/colors_manager.dart';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomeScreen(),
//   ));
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Flowery rider",
                style: GoogleFonts.imFellEnglish(
            fontSize: 20,
            color: ColorManager.primaryColor,
          ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => const CustomFlowerOrder(price: "3000",),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


