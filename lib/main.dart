import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/observer/bloc_observer.dart';
import 'package:tracking_app/firebase_options.dart';
import 'package:tracking_app/my_app.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  ApiManager.init();
  final authCubit = getIt<AuthCubit>();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: BlocProvider<AuthCubit>(
        create: (context) => authCubit,
        child: MyApp(),
      ),
    ),
  );
}
