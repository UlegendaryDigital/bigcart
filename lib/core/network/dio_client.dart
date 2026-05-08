import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/config/app_config.dart';
import '../../app/constants/app_constants.dart';

final appConfigProvider = Provider<AppConfig>((ref) => AppConfig.dev);

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: AppConstants.defaultTimeout,
      receiveTimeout: AppConstants.defaultTimeout,
      headers: const {'Content-Type': 'application/json'},
    ),
  );
  return dio;
});
