// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart'
    as _i1022;
import 'package:flutter_boilerplate_core/utils/injection/di_module.dart'
    as _i274;
import 'package:flutter_boilerplate_core/utils/network/api_client.dart'
    as _i961;
import 'package:flutter_boilerplate_core/utils/storage/shared_prefs_impl.dart'
    as _i216;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/hive_ce_flutter.dart' as _i965;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dIModule = _$DIModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => dIModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i974.Logger>(() => dIModule.logger);
    gh.lazySingleton<_i361.Dio>(() => dIModule.dio);
    gh.factory<String>(() => dIModule.baseUrl, instanceName: 'baseUrl');
    await gh.factoryAsync<_i965.Box<String>>(
      () => dIModule.homeBox,
      instanceName: 'home_cache',
      preResolve: true,
    );
    gh.lazySingleton<_i1022.LocalStorage>(
      () => _i216.SharedPrefsImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i961.ApiClient>(
      () => _i961.ApiClient(
        dio: gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
        connectTimeout: gh<Duration>(),
        receiveTimeout: gh<Duration>(),
        maxRetries: gh<int>(),
      ),
    );
    return this;
  }
}

class _$DIModule extends _i274.DIModule {}
