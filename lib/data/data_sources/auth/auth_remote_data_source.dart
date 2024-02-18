import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/auth/auth_remote_data_source_impl.dart';
import 'package:wenia_test/data/dtos/user_dto.dart';

@lazySingleton
abstract class AuthRemoteDataSource {
  Future<Result<UserDto?>> authUser({
    required final String email,
    required final String password,
  });

  Stream<UserDto?> checkAuthChanges();

  UserDto? getCurrentUser();

  Future<void> logoutUser();

  @factoryMethod
  static AuthRemoteDataSource create(final FirebaseAuth client) => AuthRemoteDataSourceImpl(client);
}
