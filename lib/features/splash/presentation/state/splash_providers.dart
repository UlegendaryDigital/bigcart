import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashInitProvider = FutureProvider.autoDispose<void>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 2));
});

