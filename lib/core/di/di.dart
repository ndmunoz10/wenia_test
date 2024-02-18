import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/di/di.config.dart';

final sl = GetIt.instance;

@injectableInit
void configureDependencies() => sl.init();
