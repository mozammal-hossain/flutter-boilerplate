import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// DI Module for core dependencies
@module
abstract class DIModule {
  /// Base URL for API calls
  @Named('baseUrl')
  String get baseUrl => FlavorConfig.instance.baseUrl;

  /// Dio client configuration
  @lazySingleton
  Logger get logger => Logger(
    level: Level.debug,
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      printEmojis: false,
    ),
  );

  /// Shared Preferences instance
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// Dio client configuration
  @lazySingleton
  Dio get dio => Dio();

  /// Hive box for home feature caching
  @preResolve
  @Named('home_cache')
  Future<Box<String>> get homeBox => Hive.openBox<String>('home_cache');
}
