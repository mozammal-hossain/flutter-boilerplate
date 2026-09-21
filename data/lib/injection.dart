import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_data/feature_home/datasources/home_remote_datasource.dart';
import 'package:injectable/injectable.dart';

/// Entry point for generating DI registrations for everything annotated
/// with `@injectable`/`@lazySingleton`/etc. inside this package's `lib/`.
///
/// Composed into the app-wide DI setup from `lib/src/injection/di.dart`.
@InjectableInit(initializerName: 'initData')
void configureDataInjection() {}

/// DI module for data-layer providers that need a factory method rather
/// than a bare `@injectable` constructor (e.g. wrapping a generated
/// Retrofit client). Lives here — not in `core`'s `DIModule` — so `core`
/// has no reason to depend on `data`, avoiding a circular package
/// dependency between `core`, `data`, and `domain`.
@module
abstract class DataModule {
  /// Home remote datasource, backed by the shared [Dio] and `baseUrl`
  /// that `core`'s `DIModule` registers.
  @lazySingleton
  HomeRemoteDatasource getHomeRemoteDatasource(
    Dio dio,
    @Named('baseUrl') String baseUrl,
  ) => HomeRemoteDatasource(dio, baseUrl: baseUrl);
}
