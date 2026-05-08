import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../app/router/app_routes.dart';
import '../state/splash_providers.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashInitProvider, (_, next) {
      next.whenData((_) => Get.offAllNamed(AppRoutes.onboarding));
    });

    // Ensure the provider is started.
    ref.watch(splashInitProvider);

    return const Scaffold(
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

