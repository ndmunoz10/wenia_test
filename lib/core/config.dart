import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wenia_test/core/di/di.dart';

Config get config => sl<Config>();

class Config {
  const Config({
    required this.apiKey,
    required this.baseUrl,
  });

  Config._(Map<String, dynamic> config)
      : baseUrl = config['baseUrl'],
        apiKey = config['apiKey'];

  static Future<void> initialize() async {
    final configJsonString = await rootBundle.loadString('config/config.json');
    final json = jsonDecode(configJsonString) as Map<String, dynamic>;
    sl.registerLazySingleton<Config>(() => Config._(json));
  }

  final String apiKey;
  final String baseUrl;
}
