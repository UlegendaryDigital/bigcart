import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_gradient_button.dart';
import '../../../../shared/widgets/oval_top_border_clipper.dart';

class Auth1WelcomePage extends ConsumerWidget {
  const Auth1WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);
    final cardHeight = (size.height * 0.44).clamp(320.0, 420.0);

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/auth1.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: const OvalTopBorderClipper(curveHeight: 48),
              child: Container(
                height: cardHeight,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 52, 24, 18),
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
                                  'Welcome',
                                  style: AppTextStyles.titleSemiBold30.copyWith(
                                    color: scheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy',
                                  style:
                                      AppTextStyles.paragraphMedium12.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          scheme.surfaceContainerLow,
                                      foregroundColor: scheme.onSurface,
                                      side: BorderSide(
                                        color: scheme.outlineVariant,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      textStyle: AppTextStyles.labelMedium15,
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _GoogleMark(),
                                        SizedBox(width: 10),
                                        Text('Continue with google'),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                AppGradientButton(
                                  label: 'Create an account',
                                  height: 54,
                                  onPressed: () =>
                                      Get.toNamed(AppRoutes.signup),
                                ),
                                const SizedBox(height: 14),
                                Center(
                                  child: TextButton(
                                    onPressed: () =>
                                        Get.toNamed(AppRoutes.login),
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

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(999),
      ),
      alignment: Alignment.center,
      child: Text(
        'G',
        style: AppTextStyles.titleBold15.copyWith(
          color: scheme.onSurface,
          height: 1,
        ),
      ),
    );
  }
}

