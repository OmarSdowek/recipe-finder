import 'package:flutter/material.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';
import '../constant/app_colors.dart';
import '../constant/app_text_style.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isGradient;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.icon,
    this.isGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.h(56),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: context.h(14)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.r(12)),
          ),
          backgroundColor: isGradient ? null : backgroundColor ?? AppColors.primaryBlue,
        ).copyWith(
          backgroundColor: isGradient
              ? MaterialStateProperty.all<Color>(Colors.transparent)
              : null,
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: isGradient
              ? BoxDecoration(
            gradient: AppColors.customGradient,
            borderRadius: BorderRadius.circular(context.r(12)),
          )
              : null,
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  SizedBox(width: context.w(8)),
                ],
                Text(
                  text,
                  style: textStyle ?? AppTextStyles.titleMediumWhiteBold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}