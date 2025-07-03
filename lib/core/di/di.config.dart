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

import '../../data/data_source_contract/auth/apply_datasource.dart' as _i130;
import '../../data/data_source_contract/auth/forget_password_datasource/forget_password_datasource.dart'
    as _i879;
import '../../data/data_source_contract/auth/forget_password_datasource/reset_password_datasource.dart'
    as _i708;
import '../../data/data_source_contract/auth/forget_password_datasource/verify_password_datasource.dart'
    as _i958;
import '../../data/data_source_contract/auth/loadcountries.dart' as _i910;
import '../../data/data_source_contract/auth/login_datasource.dart' as _i1048;
import '../../data/data_source_contract/auth/logout_datasource.dart' as _i883;
import '../../data/data_source_contract/get_driver_orders_datasourse.dart'
    as _i629;
import '../../data/data_source_contract/get_route_datasource_repo.dart'
    as _i1071;
import '../../data/data_source_contract/get_specific_product_datasource.dart'
    as _i312;
import '../../data/data_source_contract/pending_orders_datasource.dart' as _i30;
import '../../data/data_source_contract/profile/change_password_datasource.dart'
    as _i523;
import '../../data/data_source_contract/profile/edit_profile_datasource.dart'
    as _i202;
import '../../data/data_source_contract/profile/get_logged_driver_data_datasource.dart'
    as _i709;
import '../../data/data_source_contract/tracking/tracking_datasource.dart'
    as _i1067;
import '../../data/data_source_contract/update_order_datasource_repo.dart'
    as _i408;
import '../../data/data_source_contract/vehicle/get_all_vehicle_datasource.dart'
    as _i619;
import '../../data/data_source_contract/vehicle/update_vehicle_datasource.dart'
    as _i1047;
import '../../data/data_source_impl/auth/apply_datasource_impl.dart' as _i619;
import '../../data/data_source_impl/auth/forget_password_datasource_impl/forget_password_datasource_impl.dart'
    as _i444;
import '../../data/data_source_impl/auth/forget_password_datasource_impl/reset_password_datasource_impl.dart'
    as _i397;
import '../../data/data_source_impl/auth/forget_password_datasource_impl/verify_reset_code_datasource_impl.dart'
    as _i869;
import '../../data/data_source_impl/auth/loadcountries_datasource_impl.dart'
    as _i826;
import '../../data/data_source_impl/auth/login_datasource_impl.dart' as _i1013;
import '../../data/data_source_impl/auth/logout_datasource_impl.dart' as _i755;
import '../../data/data_source_impl/get_driver_orders_datasourse_impl.dart'
    as _i628;
import '../../data/data_source_impl/get_route_data_source_repo_impl.dart'
    as _i930;
import '../../data/data_source_impl/get_specific_product_datasource_impl.dart'
    as _i351;
import '../../data/data_source_impl/pending_orders_datasource_impl.dart'
    as _i345;
import '../../data/data_source_impl/profile/change_password_datasource_impl.dart'
    as _i1047;
import '../../data/data_source_impl/profile/edit_profile_datasource_impl.dart'
    as _i521;
import '../../data/data_source_impl/profile/get_driver_profile_datasource_impl.dart'
    as _i1031;
import '../../data/data_source_impl/tracking/tracking_datasource_impl.dart'
    as _i947;
import '../../data/data_source_impl/update_order_data_source_repo_impl.dart'
    as _i988;
import '../../data/data_source_impl/vehicle/get_all_vehicle_data_source_impl.dart'
    as _i272;
import '../../data/data_source_impl/vehicle/update_vehicle_data_source_impl.dart'
    as _i502;
import '../../data/repo_impl/auth/apply_repo_impl.dart' as _i240;
import '../../data/repo_impl/auth/forget_password_repo_impl/forget_password_repo_impl.dart'
    as _i363;
import '../../data/repo_impl/auth/forget_password_repo_impl/reset_password_repo_impl.dart'
    as _i704;
import '../../data/repo_impl/auth/forget_password_repo_impl/verify_reset_code_repo_impl.dart'
    as _i532;
import '../../data/repo_impl/auth/loadcountries_repo_impl.dart' as _i300;
import '../../data/repo_impl/auth/login_repo_impl.dart' as _i314;
import '../../data/repo_impl/auth/logout_repo_impl.dart' as _i355;
import '../../data/repo_impl/get_driver_orders_repo_impl.dart' as _i61;
import '../../data/repo_impl/get_route_repo_impl.dart' as _i1047;
import '../../data/repo_impl/get_specific_product_repo_impl.dart' as _i288;
import '../../data/repo_impl/pending_orders_repo_impl.dart' as _i360;
import '../../data/repo_impl/profile/change_password_repo_impl.dart' as _i517;
import '../../data/repo_impl/profile/edit_profile_repo_impl.dart' as _i333;
import '../../data/repo_impl/profile/profile_repo_impl.dart' as _i114;
import '../../data/repo_impl/tracking/tracking_repo_impl.dart' as _i481;
import '../../data/repo_impl/update_order_repo_impl.dart' as _i397;
import '../../data/repo_impl/vehicle/updatevehicle_repo_impl.dart' as _i413;
import '../../data/repo_impl/vehicle/vehicle_repo_impl.dart' as _i660;
import '../../domain/repo_contract/auth/apply_contract.dart' as _i196;
import '../../domain/repo_contract/auth/forget_password_repo/forget_password_repo.dart'
    as _i883;
import '../../domain/repo_contract/auth/forget_password_repo/reset_password_repo.dart'
    as _i151;
import '../../domain/repo_contract/auth/forget_password_repo/verify_reset_code_repo.dart'
    as _i389;
import '../../domain/repo_contract/auth/loadcountries_contract.dart' as _i317;
import '../../domain/repo_contract/auth/login_repo.dart' as _i284;
import '../../domain/repo_contract/auth/logout_repo_contract.dart' as _i8;
import '../../domain/repo_contract/get_driver_orders_repo.dart' as _i169;
import '../../domain/repo_contract/get_route_repo.dart' as _i212;
import '../../domain/repo_contract/get_specific_product_repo.dart' as _i555;
import '../../domain/repo_contract/pending_orders_repo.dart' as _i1031;
import '../../domain/repo_contract/profile/change_password_repo.dart' as _i968;
import '../../domain/repo_contract/profile/edit_profile_repo.dart' as _i301;
import '../../domain/repo_contract/profile/profile_repo.dart' as _i689;
import '../../domain/repo_contract/tracking/tracking_repo.dart' as _i861;
import '../../domain/repo_contract/update_order_repo.dart' as _i314;
import '../../domain/repo_contract/vehicle/update_vehicle.dart' as _i291;
import '../../domain/repo_contract/vehicle/vehicle_contract.dart' as _i1042;
import '../../domain/use_cases/auth/apply_usecase.dart' as _i212;
import '../../domain/use_cases/auth/forget_password/forget_password_usecase.dart'
    as _i587;
import '../../domain/use_cases/auth/forget_password/reset_password_usecase.dart'
    as _i221;
import '../../domain/use_cases/auth/forget_password/verify_reset_code_usecase.dart'
    as _i750;
import '../../domain/use_cases/auth/loadcountries.dart' as _i1000;
import '../../domain/use_cases/auth/login_usecase.dart' as _i912;
import '../../domain/use_cases/auth/logout_usecase.dart' as _i722;
import '../../domain/use_cases/get_driver_orders_usecase.dart' as _i1017;
import '../../domain/use_cases/get_pending_orders_usecase.dart' as _i966;
import '../../domain/use_cases/get_route_usecase.dart' as _i1027;
import '../../domain/use_cases/get_specific_product_usecase.dart' as _i789;
import '../../domain/use_cases/profile/change_password_usecase.dart' as _i403;
import '../../domain/use_cases/profile/edit_profile_usecase.dart' as _i666;
import '../../domain/use_cases/profile/get_profile_details_usecase.dart'
    as _i444;
import '../../domain/use_cases/profile/upload_photo_usecase.dart' as _i18;
import '../../domain/use_cases/start_order_usecase.dart' as _i468;
import '../../domain/use_cases/tracking/get_user_address_usecase.dart' as _i405;
import '../../domain/use_cases/tracking/update_driver_Address_usecase.dart'
    as _i259;
import '../../domain/use_cases/tracking/update_driver_Info_usecase.dart'
    as _i475;
import '../../domain/use_cases/tracking/update_order_status_usecase.dart'
    as _i26;
import '../../domain/use_cases/update_order_use_case.dart' as _i653;
import '../../domain/use_cases/vehicle/getall_vehicle.dart' as _i794;
import '../../domain/use_cases/vehicle/update_vehicle.dart' as _i337;
import '../../ui/Auth/view_model/cubit/auth_cubit.dart' as _i906;
import '../../ui/map/view/cubit/map_cubit.dart' as _i126;
import '../../ui/order_details_screen/view_model/cubit/order_details_cubit.dart'
    as _i598;
import '../../ui/tabs/home_tab/view_model/home_cubit.dart' as _i894;
import '../../ui/tabs/orders_tab/view_model/orders_cubit.dart' as _i893;
import '../../ui/tabs/profile_tab/change_password/cubit/change_password_cubit.dart'
    as _i50;
import '../../ui/tabs/profile_tab/edit_profile_screen/view_model/edit_profile_cubit.dart'
    as _i45;
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
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.singleton<_i299.CacheHelper>(() => _i299.CacheHelper());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.factory<_i523.ChangePasswordDatasource>(
        () => _i1047.ChangePasswordDatasourceImpl(
              gh<_i1047.ApiManager>(),
              gh<_i299.CacheHelper>(),
            ));
    gh.factory<_i619.getallvehicledatasourceContract>(
        () => _i272.getallvehicleimpl(gh<_i1047.ApiManager>()));
    gh.factory<_i1067.TrackingDataSource>(() => _i947.TrackingDataSourceimpl());
    gh.factory<_i202.EditProfileDatasource>(
        () => _i521.EditProfileDatasourceImpl(
              gh<_i1047.ApiManager>(),
              gh<_i299.CacheHelper>(),
            ));
    gh.factory<_i312.GetSpecificProductDatasource>(
        () => _i351.GetSpecificProductDatasourceImpl(
              cacheHelper: gh<_i299.CacheHelper>(),
              apiManager: gh<_i1047.ApiManager>(),
            ));
    gh.factory<_i883.LogoutDatasource>(() => _i755.LogoutDatasourceImpl(
          apiManager: gh<_i1047.ApiManager>(),
          cacheHelper: gh<_i299.CacheHelper>(),
        ));
    gh.factory<_i709.ProfileDatasource>(() => _i1031.ProfileDatasourceImpl(
          gh<_i1047.ApiManager>(),
          gh<_i299.CacheHelper>(),
        ));
    gh.factory<_i861.TrackingRepo>(
        () => _i481.TrackingRepoImpl(gh<_i1067.TrackingDataSource>()));
    gh.factory<_i910.loadcountriesDataSourseRepo>(
        () => _i826.loadcountriesDataSourceImpl());
    gh.factory<_i408.UpdateOrderdatasource>(
        () => _i988.UpdateOrderDataSourceImpl(
              cacheHelper: gh<_i299.CacheHelper>(),
              apiManager: gh<_i1047.ApiManager>(),
            ));
    gh.factory<_i1048.LoginDataSourceRepo>(() => _i1013.LoginDatasourceImpl(
          gh<_i1047.ApiManager>(),
          gh<_i299.CacheHelper>(),
        ));
    gh.factory<_i30.PendingOrdersDataSource>(
        () => _i345.PendingOrdersDataSourceImpl(
              cacheHelper: gh<_i299.CacheHelper>(),
              apiManager: gh<_i1047.ApiManager>(),
            ));
    gh.factory<_i629.GetDriverOrdersDatasourse>(
        () => _i628.GetDriverOrdersDatasourseImpl(
              cacheHelper: gh<_i299.CacheHelper>(),
              apiManager: gh<_i1047.ApiManager>(),
            ));
    gh.factory<_i1047.UpdateVehicleDatasource>(
        () => _i502.UpdateVehicleDataSourceImpl(
              gh<_i1047.ApiManager>(),
              gh<_i299.CacheHelper>(),
            ));
    gh.factory<_i475.UpdateDriverInfoUsecase>(
        () => _i475.UpdateDriverInfoUsecase(gh<_i861.TrackingRepo>()));
    gh.factory<_i26.UpdateOrderStatusUsecase>(
        () => _i26.UpdateOrderStatusUsecase(gh<_i861.TrackingRepo>()));
    gh.factory<_i405.GetUserAddressUsecase>(
        () => _i405.GetUserAddressUsecase(gh<_i861.TrackingRepo>()));
    gh.factory<_i259.UpdateDriverAddressUsecase>(
        () => _i259.UpdateDriverAddressUsecase(gh<_i861.TrackingRepo>()));
    gh.factory<_i1042.VehicleContract>(() =>
        _i660.vehicleRepoImpl(gh<_i619.getallvehicledatasourceContract>()));
    gh.factory<_i130.Applydatasourcecontract>(
        () => _i619.applyDataSourceImpl(gh<_i1047.ApiManager>()));
    gh.factory<_i1031.PendingOrdersRepo>(
        () => _i360.PendingOrdersRepoImpl(gh<_i30.PendingOrdersDataSource>()));
    gh.factory<_i284.LoginRepo>(
        () => _i314.SigninRepoImpl(gh<_i1048.LoginDataSourceRepo>()));
    gh.factory<_i689.ProfileRepo>(
        () => _i114.ProfileRepoImpl(gh<_i709.ProfileDatasource>()));
    gh.factory<_i1071.GetRouteDatasourceRepo>(() =>
        _i930.GetRouteDataSourceRepoImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i314.UpdateOrderRepo>(
        () => _i397.UpdateOrderRepoImpl(gh<_i408.UpdateOrderdatasource>()));
    gh.factory<_i879.ForgetpasswordDataSourseRepo>(() =>
        _i444.ForgetpasswordDataSourceRepoImpl(
            apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i444.GetProfileDetailsUsecase>(
        () => _i444.GetProfileDetailsUsecase(gh<_i689.ProfileRepo>()));
    gh.factory<_i169.GetDriverOrdersRepo>(() =>
        _i61.GetDriverOrdersRepoImpl(gh<_i629.GetDriverOrdersDatasourse>()));
    gh.factory<_i317.loadCountriesRepo>(() => _i300.loadcountriesRepoImpl(
        load: gh<_i910.loadcountriesDataSourseRepo>()));
    gh.factory<_i708.ResetpasswordDataSourceRepo>(() =>
        _i397.Resetpassworddatasourcerepoimpl(
            apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i968.ChangePasswordRepo>(() =>
        _i517.ChangePasswordRepoImpl(gh<_i523.ChangePasswordDatasource>()));
    gh.factory<_i1000.loadcountriesUseCase>(
        () => _i1000.loadcountriesUseCase(gh<_i317.loadCountriesRepo>()));
    gh.factory<_i958.VerifyresetcodeRepoDataSource>(() =>
        _i869.Verifyresetcoderepodatasourceimpl(
            apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i389.VerifyresetcodeRepo>(() => _i532.Verifyresetcoderepoimpl(
        gh<_i958.VerifyresetcodeRepoDataSource>()));
    gh.factory<_i794.GetallVehicleUseCase>(() => _i794.GetallVehicleUseCase(
        vehicleContract: gh<_i1042.VehicleContract>()));
    gh.factory<_i301.EditProfileRepo>(
        () => _i333.EditProfileRepoImpl(gh<_i202.EditProfileDatasource>()));
    gh.factory<_i666.EditProfileUsecase>(
        () => _i666.EditProfileUsecase(gh<_i301.EditProfileRepo>()));
    gh.factory<_i18.UploadPhotoUsecase>(
        () => _i18.UploadPhotoUsecase(gh<_i301.EditProfileRepo>()));
    gh.factory<_i151.ResetpasswordRepo>(() =>
        _i704.Resetpasswordrepoimpl(gh<_i708.ResetpasswordDataSourceRepo>()));
    gh.factory<_i883.ForgetpasswordRepo>(() => _i363.Forgetpasswordrepoimpl(
        forgetpassword_data_sourse_repo:
            gh<_i879.ForgetpasswordDataSourseRepo>()));
    gh.factory<_i212.GetRouteRepo>(
        () => _i1047.GetRouteRepoImpl(gh<_i1071.GetRouteDatasourceRepo>()));
    gh.factory<_i555.GetSpecificProductRepo>(() =>
        _i288.GetSpecificProductRepoImpl(
            gh<_i312.GetSpecificProductDatasource>()));
    gh.factory<_i1027.GetRouteUseCase>(
        () => _i1027.GetRouteUseCase(getRouteRepo: gh<_i212.GetRouteRepo>()));
    gh.factory<_i8.LogoutRepoContract>(() =>
        _i355.LogoutRepoImpl(logoutDatasource: gh<_i883.LogoutDatasource>()));
    gh.factory<_i587.ForgetPasswordUseCase>(() => _i587.ForgetPasswordUseCase(
        forgetPassword: gh<_i883.ForgetpasswordRepo>()));
    gh.factory<_i291.UpdateVehicleRepo>(() => _i413.UpdateVehicleRepoImpl(
        updateVehicleDatasource: gh<_i1047.UpdateVehicleDatasource>()));
    gh.factory<_i750.VerifyresetcodeUseCase>(() =>
        _i750.VerifyresetcodeUseCase(repo: gh<_i389.VerifyresetcodeRepo>()));
    gh.factory<_i196.applyRepoContract>(() => _i240.applyRepoImpl(
        applyDataSource: gh<_i130.Applydatasourcecontract>()));
    gh.factory<_i1017.GetDriverOrdersUsecase>(() =>
        _i1017.GetDriverOrdersUsecase(
            getDriverOrdersRepo: gh<_i169.GetDriverOrdersRepo>()));
    gh.factory<_i912.LoginUsecase>(
        () => _i912.LoginUsecase(loginRepo: gh<_i284.LoginRepo>()));
    gh.factory<_i966.GetPendingOrdersUseCase>(() =>
        _i966.GetPendingOrdersUseCase(
            pendingOrdersRepo: gh<_i1031.PendingOrdersRepo>()));
    gh.factory<_i468.StartOrderUseCase>(() => _i468.StartOrderUseCase(
        pendingOrdersRepo: gh<_i1031.PendingOrdersRepo>()));
    gh.factory<_i653.UpdateOrderUseCase>(() =>
        _i653.UpdateOrderUseCase(updateOrderRepo: gh<_i314.UpdateOrderRepo>()));
    gh.factory<_i722.LogoutUsecase>(() =>
        _i722.LogoutUsecase(logoutRepoContract: gh<_i8.LogoutRepoContract>()));
    gh.factory<_i598.OrderDetailsCubit>(() => _i598.OrderDetailsCubit(
          gh<_i653.UpdateOrderUseCase>(),
          gh<_i475.UpdateDriverInfoUsecase>(),
          gh<_i26.UpdateOrderStatusUsecase>(),
        ));
    gh.factory<_i221.ResetpasswordUsecase>(
        () => _i221.ResetpasswordUsecase(repo: gh<_i151.ResetpasswordRepo>()));
    gh.factory<_i403.ChangePasswordUsecase>(
        () => _i403.ChangePasswordUsecase(gh<_i968.ChangePasswordRepo>()));
    gh.factory<_i789.GetSpecificProductUsecase>(() =>
        _i789.GetSpecificProductUsecase(
            getSpecificProductRepo: gh<_i555.GetSpecificProductRepo>()));
    gh.factory<_i126.MapCubit>(() => _i126.MapCubit(
          gh<_i1027.GetRouteUseCase>(),
          gh<_i405.GetUserAddressUsecase>(),
          gh<_i259.UpdateDriverAddressUsecase>(),
        ));
    gh.factory<_i45.EditProfileCubit>(() => _i45.EditProfileCubit(
          gh<_i666.EditProfileUsecase>(),
          gh<_i18.UploadPhotoUsecase>(),
        ));
    gh.factory<_i894.HomeCubit>(() => _i894.HomeCubit(
          gh<_i966.GetPendingOrdersUseCase>(),
          gh<_i468.StartOrderUseCase>(),
          gh<_i299.CacheHelper>(),
        ));
    gh.factory<_i337.UpdateVehicleUsecase>(() => _i337.UpdateVehicleUsecase(
        updateVehicleRepo: gh<_i291.UpdateVehicleRepo>()));
    gh.factory<_i212.ApplyUseCase>(
        () => _i212.ApplyUseCase(applyContract: gh<_i196.applyRepoContract>()));
    gh.factory<_i893.OrdersCubit>(() => _i893.OrdersCubit(
          gh<_i1017.GetDriverOrdersUsecase>(),
          gh<_i789.GetSpecificProductUsecase>(),
        ));
    gh.factory<_i50.ChangePasswordCubit>(
        () => _i50.ChangePasswordCubit(gh<_i403.ChangePasswordUsecase>()));
    gh.factory<_i906.AuthCubit>(() => _i906.AuthCubit(
          gh<_i337.UpdateVehicleUsecase>(),
          gh<_i912.LoginUsecase>(),
          gh<_i1000.loadcountriesUseCase>(),
          gh<_i587.ForgetPasswordUseCase>(),
          gh<_i221.ResetpasswordUsecase>(),
          gh<_i750.VerifyresetcodeUseCase>(),
          gh<_i212.ApplyUseCase>(),
          gh<_i444.GetProfileDetailsUsecase>(),
          gh<_i794.GetallVehicleUseCase>(),
          gh<_i722.LogoutUsecase>(),
        ));
    return this;
  }
}

class _$LoggerModule extends _i279.LoggerModule {}
