import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/route/routes.dart';

import 'core/route/app_routes.dart';

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 884), // حجم التصميم الأصلي (iPhone X كمثال)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          initialRoute: Routes.splash,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}