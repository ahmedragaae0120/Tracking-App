// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../../data/data_source_contract/auth/auth_datasource.dart' as _i934;
import '../../data/data_source_contract/auth/login_datasource.dart' as _i1048;
import '../../data/data_source_contract/vehicle/get_all_vehicle_datasource.dart'
    as _i619;
import '../../data/data_source_impl/auth/auth_datasource_impl.dart' as _i536;
import '../../data/data_source_impl/auth/login_datasource_impl.dart' as _i1013;
import '../../data/data_source_impl/vehicle/get_all_vehicle_data_source_impl.dart'
    as _i272;
import '../../data/repo_impl/auth/auth_repo_impl.dart' as _i947;
import '../../data/repo_impl/auth/login_repo_impl.dart' as _i314;
import '../../data/repo_impl/vehicle/vehicle_repo_impl.dart' as _i660;
import '../../domain/repo_contract/auth/auth_contract.dart' as _i409;
import '../../domain/repo_contract/auth/login_repo.dart' as _i284;
import '../../domain/repo_contract/vehicle/vehicle_contract.dart' as _i1042;
import '../../domain/use_cases/auth/apply_usecase.dart' as _i212;
import '../../domain/use_cases/auth/login_usecase.dart' as _i912;
import '../../domain/use_cases/vehicle/getall_vehicle.dart' as _i794;
import '../../ui/Auth/view_model/cubit/auth_cubit.dart' as _i906;
import '../api/api_manager.dart' as _i1047;
import '../cache/shared_pref.dart' as _i299;
import '../logger/logger_module.dart' as _i279;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    gh.factory<_i912.LoginUsecase>(() => _i912.LoginUsecase());
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.singleton<_i299.CacheHelper>(() => _i299.CacheHelper());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.factory<_i619.getallvehicledatasourceContract>(
        () => _i272.getallvehicleimpl(gh<_i1047.ApiManager>()));
    gh.factory<_i284.LoginRepo>(() => _i314.LoginRepoImpl());
    gh.factory<_i1048.LoginDatasource>(() => _i1013.LoginDatasourceImpl());
    gh.factory<_i1042.VehicleContract>(() =>
        _i660.vehicleRepoImpl(gh<_i619.getallvehicledatasourceContract>()));
    gh.factory<_i934.AuthDataSource>(
        () => _i536.AuthDataSourceImpl(gh<_i1047.ApiManager>()));
    gh.factory<_i794.GetallVehicleUseCase>(() => _i794.GetallVehicleUseCase(
        vehicleContract: gh<_i1042.VehicleContract>()));
    gh.factory<_i409.AuthrRepoContract>(() =>
        _i947.AuthRepositoryImpl(authDataSource: gh<_i934.AuthDataSource>()));
    gh.factory<_i212.ApplyUseCase>(
        () => _i212.ApplyUseCase(authContract: gh<_i409.AuthrRepoContract>()));
    gh.factory<_i906.AuthCubit>(() => _i906.AuthCubit(
          gh<_i212.ApplyUseCase>(),
          gh<_i794.GetallVehicleUseCase>(),
        ));
    return this;
  }
}

class _$LoggerModule extends _i279.LoggerModule {}
