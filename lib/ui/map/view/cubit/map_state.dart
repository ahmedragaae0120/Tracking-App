part of 'map_cubit.dart';

sealed class MapState {}

/// حالة السكون – لسه الكيوبت مفيش أي عمليات بدأت
final class MapStateIdle extends MapState {}

/// تحميل مسار (Polyline) أو ماركرز
final class MapRouteLoading extends MapState {}

/// البيانات جاهزة – نقدر نعرض الخريطة كاملة
final class MapDataReady extends MapState {}

final class CurrentLocationChanged extends MapState {}

/// حالة الخطأ – لأي مشكلة في الـ API أو اللوكيشن
final class MapStateError extends MapState {
  final String message;

  MapStateError(this.message);
}
