import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_gradient_button.dart';
import '../../../../shared/widgets/oval_top_border_clipper.dart';

final _emailControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);
    return controller;
  },
);

final _passwordControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);
    return controller;
  },
);

final _obscurePasswordProvider = NotifierProvider<_BoolNotifier, bool>(
  () => _BoolNotifier(initial: true),
);

class _BoolNotifier extends Notifier<bool> {
  _BoolNotifier({this.initial = false});
  final bool initial;

  @override
  bool build() => initial;

  void toggle() => state = !state;
}

class Auth1SignupPage extends ConsumerWidget {
  const Auth1SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);
    final cardHeight = (size.height * 0.60).clamp(380.0, 560.0);

    final emailController = ref.watch(_emailControllerProvider);
    final passwordController = ref.watch(_passwordControllerProvider);
    final obscurePassword = ref.watch(_obscurePasswordProvider);

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/signup.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Welcome',
                    style: AppTextStyles.titleSemiBold20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: const OvalTopBorderClipper(curveHeight: 48),
              child: Container(
                height: cardHeight,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 18),
                color: scheme.surface,
                child: SafeArea(
                  top: false,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create account',
                                  style: AppTextStyles.titleBold25.copyWith(
                                    color: scheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Quickly create account',
                                  style:
                                      AppTextStyles.paragraphMedium12.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: 'Email address',
                                    prefixIcon: Icon(Icons.email_outlined),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  controller: passwordController,
                                  obscureText: obscurePassword,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon:
                                        const Icon(Icons.lock_outline_rounded),
                                    suffixIcon: IconButton(
                                      onPressed: () => ref
                                          .read(_obscurePasswordProvider.notifier)
                                          .toggle(),
                                      icon: Icon(
                                        obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 28),
                                AppGradientButton(
                                  label: 'Signup',
                                  height: 56,
                                  onPressed: () =>
                                      Get.toNamed(AppRoutes.verifyNumber),
                                ),
                                const SizedBox(height: 14),
                                Center(
                                  child: TextButton(
                                    onPressed: () =>
                                        Get.offAllNamed(AppRoutes.login),
                                    style: TextButton.styleFrom(
                                      foregroundColor: scheme.onSurfaceVariant,
                                      textStyle:
                                          AppTextStyles.paragraphMedium12,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: AppTextStyles.paragraphMedium12
                                            .copyWith(
                                          color: scheme.onSurfaceVariant,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text:
                                                'Already have an account ? ',
                                          ),
                                          TextSpan(
                                            text: 'Login',
                                            style: AppTextStyles.titleSemiBold15
                                                .copyWith(
                                              color: scheme.onSurface,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

