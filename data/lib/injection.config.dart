// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:flutter_boilerplate_data/feature_home/datasources/home_remote_datasource.dart'
    as _i1015;
import 'package:flutter_boilerplate_data/feature_home/repositories/home_repository_impl.dart'
    as _i4;
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart'
    as _i855;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive_ce.dart' as _i1055;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initData({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i855.HomeRepository>(
      () => _i4.HomeRepositoryImpl(
        remoteDatasource: gh<_i1015.HomeRemoteDatasource>(),
        cacheBox: gh<_i1055.Box<String>>(instanceName: 'home_cache'),
      ),
    );
    return this;
  }
}
