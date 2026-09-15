import 'package:campus_connect/core/routes/app_routes.dart';
import 'package:campus_connect/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      getPages: AppRoutes.pages,

      home: const HomeView(),
    );
  }
}
