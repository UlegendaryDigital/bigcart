import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingIndexProvider = NotifierProvider<OnboardingIndexController, int>(
  OnboardingIndexController.new,
);

class OnboardingIndexController extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}

