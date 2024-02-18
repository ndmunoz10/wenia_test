import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/auth/auth_remote_data_source.dart';
import 'package:wenia_test/data/repositories/auth/auth_repository_impl.dart';
import 'package:wenia_test/domain/models/user_model.dart';

@lazySingleton
abstract class AuthRepository {
  Future<Result<UserModel?>> authUser({
    required final String email,
    required final String password,
  });

  Stream<UserModel?> checkAuthChanges();

  UserModel? getCurrentUser();

  Future<void> logoutUser();

  @factoryMethod
  static AuthRepository create(final AuthRemoteDataSource dataSource) => AuthRepositoryImpl(dataSource);
}
