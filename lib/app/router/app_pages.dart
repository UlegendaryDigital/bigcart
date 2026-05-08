import 'package:get/get.dart';

import '../../features/auth/presentation/pages/auth1_signup_page.dart';
import '../../features/auth/presentation/pages/auth1_welcome_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/verify_number_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
    ),
    GetPage(
      name: AppRoutes.authWelcome,
      page: () => const Auth1WelcomePage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const Auth1SignupPage(),
    ),
    GetPage(
      name: AppRoutes.verifyNumber,
      page: () => const VerifyNumberPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
  ];
}
