import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_style.dart';


class LoginText extends StatelessWidget {
  final String firstly;
  final String secondly;
  final void Function()? onTap;

  const LoginText(this.firstly, this.secondly, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.whiteColor,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: firstly,
            style: AppTextStyles.bodyRegularSecondary,
            children: [
              TextSpan(
                text: secondly,
                style: AppTextStyles.bodyBoldSecondary.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}