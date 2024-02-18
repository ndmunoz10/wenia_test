import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/auth/auth_remote_data_source.dart';
import 'package:wenia_test/data/dtos/user_dto.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<UserModel?>> authUser({required String email, required String password}) {
    return _remoteDataSource.authUser(email: email, password: password).then((final Result<UserDto?> user) =>
        user.map((final UserDto? user) => user == null ? null : UserModel.fromDto(user: user)));
  }

  @override
  Stream<UserModel?> checkAuthChanges() {
    return _remoteDataSource
        .checkAuthChanges()
        .map((final UserDto? user) => user == null ? null : UserModel.fromDto(user: user));
  }

  @override
  UserModel? getCurrentUser() {
    final currentUser = _remoteDataSource.getCurrentUser();
    if (currentUser != null) {
      return UserModel.fromDto(user: currentUser);
    }
    return null;
  }

  @override
  Future<void> logoutUser() {
    return _remoteDataSource.logoutUser();
  }
}
