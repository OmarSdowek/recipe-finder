import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/core/constant/app_colors.dart';
import 'package:food_app/core/constant/assets_manger.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';

import '../../../../core/constant/app_text_style.dart';
import '../../../../core/route/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.signUp);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(gradient: AppColors.customGradient),
            ),

            SvgPicture.asset(
              AssetsManger.splashBackGround,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetsManger.logo),
                Text(
                  "Recipe Finder",
                  style: AppTextStyles.titleMediumWhiteBold,
                ),
                Text(
                  "COOK WITH PASSION",
                  style: AppTextStyles.semibold14White.copyWith(
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 60,
              child: Column(
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.3,
                    child: const LinearProgressIndicator(
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                      minHeight: 2,
                    ),
                  ),
                  context.verticalSpace(12),
                  Text(
                    "LOADING KITCHEN",
                    style: AppTextStyles.semibold12White.copyWith(
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}