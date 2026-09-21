import 'dart:async';

import 'package:flutter_boilerplate_core/utils/injection/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

/// Global service locator instance
final GetIt getIt = GetIt.instance;

/// Alternative name for service locator (common in Clean Architecture)
final GetIt sl = getIt;

/// Main entry point for configuring dependencies
///
/// Call this function in `main()` before `runApp()`
@InjectableInit()
Future<void> configureDependencies([String? environment]) async {
  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize core dependencies from generated config
  await getIt.init(environment: environment);
}

/// Helper to reset dependencies (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
}

/// Scope management helpers
///
/// Use these to manage feature-specific dependency lifecycles
extension DependencyScopeX on GetIt {
  /// Pushes a new scope for a feature
  void pushFeatureScope(String scopeName) {
    if (!(getIt.currentScopeName?.contains(scopeName) ?? false)) {
      getIt.pushNewScope(scopeName: scopeName);
    }
  }

  /// Pops the current scope
  Future<void> popScope() async {
    await getIt.popScope();
  }
}
