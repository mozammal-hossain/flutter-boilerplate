/// Dependency Injection Setup
///
/// Configures dependencies from every package (core, domain, data) plus
/// the app's own feature Cubits/Blocs, then re-exports the core package's
/// service locator (`getIt`/`sl`) and helpers for use throughout the app.
library;

import 'package:flutter_boilerplate/src/injection/app_injection.config.dart';
import 'package:flutter_boilerplate_core/utils/injection/di.dart' as core_di;
import 'package:flutter_boilerplate_data/injection.config.dart';
import 'package:flutter_boilerplate_domain/injection.config.dart';

export 'package:flutter_boilerplate_core/utils/injection/di.dart'
    hide configureDependencies;

/// Main entry point for configuring dependencies across every package.
///
/// Call this function in `main()` before `runApp()`.
Future<void> configureDependencies([String? environment]) async {
  await core_di.configureDependencies(environment);
  core_di.getIt.initDomain(environment: environment);
  core_di.getIt.initData(environment: environment);
  core_di.getIt.initApp(environment: environment);
}
