import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_gradient_button.dart';

final _otpControllersProvider =
    Provider.autoDispose<List<TextEditingController>>((ref) {
  final controllers = List.generate(6, (_) => TextEditingController());
  ref.onDispose(() {
    for (final c in controllers) {
      c.dispose();
    }
  });
  return controllers;
});

final _otpFocusNodesProvider = Provider.autoDispose<List<FocusNode>>((ref) {
  final nodes = List.generate(6, (_) => FocusNode());
  ref.onDispose(() {
    for (final n in nodes) {
      n.dispose();
    }
  });
  return nodes;
});

class VerifyNumberPage extends ConsumerWidget {
  const VerifyNumberPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final controllers = ref.watch(_otpControllersProvider);
    final focusNodes = ref.watch(_otpFocusNodesProvider);

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Text(
                    'Verify Email',
                    style: AppTextStyles.titleSemiBold15.copyWith(
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Verify your email',
                        style: AppTextStyles.titleBold25.copyWith(
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Enter your OTP code below',
                        style: AppTextStyles.paragraphMedium12.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (i) {
                          return _OtpBox(
                            controller: controllers[i],
                            focusNode: focusNodes[i],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (i < 5) {
                                  focusNodes[i + 1].requestFocus();
                                } else {
                                  focusNodes[i].unfocus();
                                }
                                return;
                              }
                              if (i > 0) {
                                focusNodes[i - 1].requestFocus();
                              }
                            },
                            onBackspaceEmpty: () {
                              if (i > 0) focusNodes[i - 1].requestFocus();
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 18),
                      AppGradientButton(
                        label: 'Next',
                        height: 56,
                        onPressed: () => Get.offAllNamed(AppRoutes.home),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        "Didn’t receive the code ?",
                        style: AppTextStyles.paragraphMedium12.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: scheme.onSurface,
                          textStyle: AppTextStyles.titleSemiBold15,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('Resend a new code'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspaceEmpty,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspaceEmpty;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 52,
      height: 56,
      child: Focus(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            onBackspaceEmpty();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: AppTextStyles.titleSemiBold15.copyWith(
            color: scheme.onSurface,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: scheme.surfaceContainerLow,
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: scheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryDark),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

