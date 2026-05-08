import 'package:get/get.dart';

import '../../features/home/presentation/pages/home_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
  ];
}
