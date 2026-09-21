// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:flutter_boilerplate_domain/feature_home/repositories/home_repository.dart'
    as _i919;
import 'package:flutter_boilerplate_domain/feature_home/usecases/get_home_data_usecase.dart'
    as _i908;
import 'package:flutter_boilerplate_domain/feature_home/usecases/get_home_detail_usecase.dart'
    as _i379;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initDomain({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i908.GetHomeDataUseCase>(
      () => _i908.GetHomeDataUseCase(gh<_i919.HomeRepository>()),
    );
    gh.factory<_i379.GetHomeDetailUseCase>(
      () => _i379.GetHomeDetailUseCase(gh<_i919.HomeRepository>()),
    );
    return this;
  }
}
