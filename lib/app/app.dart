import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'router/app_pages.dart';
import 'router/app_routes.dart';
import 'theme/app_theme.dart';

class BigCartApp extends ConsumerWidget {
  const BigCartApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
      title: 'BigCart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
