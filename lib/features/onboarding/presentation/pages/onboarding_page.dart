import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_gradient_button.dart';
import '../../../../shared/widgets/oval_top_border_clipper.dart';
import '../state/onboarding_controller.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  static const _pages = <({String image, String title, BoxFit fit})>[
    (
      image: 'assets/splash1.png',
      title: 'Premium Food\nAt Your Doorstep',
      fit: BoxFit.contain,
    ),
    (
      image: 'assets/splash2.png',
      title: 'Buy Premium \nQuality Fruits',
      fit: BoxFit.cover,
    ),
    (
      image: 'assets/splash3.png',
      title: 'Buy Quality \nDairy Products',
      fit: BoxFit.cover,
    ),
    (
      image: 'assets/splash4.png',
      title: 'Get Discounts \nOn All Products',
      fit: BoxFit.cover,
    ),
  ];

  static int get _pageCount => _pages.length;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final index = ref.watch(onboardingIndexProvider);

    final size = MediaQuery.sizeOf(context);
    final cardHeight = (size.height * 0.42).clamp(320.0, 380.0);

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pageCount,
              onPageChanged: (i) =>
                  ref.read(onboardingIndexProvider.notifier).setIndex(i),
              itemBuilder: (context, i) {
                final page = _pages[i];

                // Page 2: edge-to-edge image, no background strips.
                if (page.fit == BoxFit.cover) {
                  return SizedBox.expand(
                    child: Image.asset(
                      page.image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  );
                }

                // Other pages keep the light-green background + centered image.
                return Container(
                  color: scheme.surfaceContainerLow,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: FractionallySizedBox(
                        widthFactor: 0.82,
                        child: Image.asset(
                          page.image,
                          fit: page.fit,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: const OvalTopBorderClipper(curveHeight: 48),
              child: Container(
                height: cardHeight,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
                color: scheme.surface,
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Text(
                        _pages[index.clamp(0, _pageCount - 1)].title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.titleBold25.copyWith(
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.paragraphMedium12.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      _DotsIndicator(
                        count: _pageCount,
                        activeIndex: index,
                        activeColor: AppColors.primaryDark,
                        inactiveColor: const Color(0xFFD8D8D8),
                      ),
                      const SizedBox(height: 18),
                      AppGradientButton(
                        label: 'Get started',
                        height: 56,
                        onPressed: () {
                          final isLast = index == _pageCount - 1;
                          if (isLast) {
                            Get.offAllNamed(AppRoutes.home);
                            return;
                          }

                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeOut,
                          );
                        },
                      ),
                    ],
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

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({
    required this.count,
    required this.activeIndex,
    required this.activeColor,
    required this.inactiveColor,
  });

  final int count;
  final int activeIndex;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(count, (i) {
        final isActive = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : 8),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

