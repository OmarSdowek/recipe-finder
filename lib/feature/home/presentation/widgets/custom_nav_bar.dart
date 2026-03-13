import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_style.dart';


class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: true,
      backgroundColor: AppColors.whiteColor,
       landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
       selectedItemColor: AppColors.gradientStart,
      unselectedItemColor: AppColors.secondaryText,
      showUnselectedLabels: true,
      selectedLabelStyle: AppTextStyles.bodyBoldSecondary,
      unselectedLabelStyle: AppTextStyles.bodyMediumSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home, color: AppColors.gradientStart),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          activeIcon: const Icon(Icons.favorite, color: AppColors.gradientStart),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person, color: AppColors.gradientStart),
          label: "Profile",
        ),
      ],
    );
  }
}