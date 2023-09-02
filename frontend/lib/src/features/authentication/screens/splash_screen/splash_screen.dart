import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/image_strings.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/features/authentication/controllers/splash_screen_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splashController.animate.value ? 1 : 0,
                child: const Image(
                  image: AssetImage(cAppLogoImage),
                  width: cDefaultSize,
                ),
              ),
            ),
            Obx(
              () => Shimmer.fromColors(
                baseColor: cSecondaryColor,
                highlightColor: cPrimaryColor,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 2000),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: Text(
                    "Fitness App",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: cPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
