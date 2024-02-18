import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wenia_test/core/config.dart';
import 'package:wenia_test/core/di/di.dart';
import 'package:wenia_test/core/router/router.dart';
import 'package:wenia_test/firebase_options.dart';
import 'package:wenia_test/presentation/features/auth/auth_guard.dart';
import 'package:wenia_test/presentation/features/home/all/all_crypt_cubit.dart';
import 'package:wenia_test/presentation/features/home/comparison/comparison_crypt_cubit.dart';
import 'package:wenia_test/presentation/features/login/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  configureDependencies();
  await Config.initialize();
  runApp(const WeniaApp());
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class WeniaApp extends StatelessWidget {
  const WeniaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => sl<LoginCubit>()),
        BlocProvider<AllCryptCubit>(create: (_) => sl<AllCryptCubit>()),
        BlocProvider<ComparisonCryptCubit>(create: (_) => sl<ComparisonCryptCubit>()),
      ],
      child: AuthGuard(
        child: MaterialApp.router(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(scaffoldBackgroundColor: Colors.black),
          routerConfig: router,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: MediaQuery.of(context).textScaler.clamp(maxScaleFactor: 2),
              ),
              child: child ?? const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
