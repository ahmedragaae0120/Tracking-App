import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_app/core/resuable_comp/text_button.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50,top: 150),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Transform.scale(
                      scale: 2, // قيمة التكبير
                      child: Lottie.asset(
                        'assets/animations/onboarding_animation.json',
                        fit: BoxFit.contain,
                        repeat: true,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30,),
                const Text("Welcome to",style: TextStyle(fontSize: 22),),
                const Text("Flowry rider app",style: TextStyle(fontSize: 22),),
                const SizedBox(height: 30,),
                CustomTextButton(
                    onPressed: (){},
                    borderColor: ColorManager.primaryColor,
                    text: "Login",
                    color: ColorManager.primaryColor,
                    textColor: ColorManager.white
                ),
                const SizedBox(height: 20,),
                CustomTextButton(
                    onPressed: (){},
                    borderColor: ColorManager.black100.withOpacity(0.2),
                    text: "Apply now",
                    color: ColorManager.white,
                    textColor: ColorManager.black
                ),
              ]
          ),
        ),
      ),
    );
  }
}