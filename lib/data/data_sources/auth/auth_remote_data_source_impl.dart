import 'package:firebase_auth/firebase_auth.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/auth/auth_remote_data_source.dart';
import 'package:wenia_test/data/dtos/user_dto.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final FirebaseAuth _client;

  @override
  Future<Result<UserDto?>> authUser({
    required final String email,
    required final String password,
  }) async {
    try {
      final credentials = await _client.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.success(credentials.user == null ? null : UserDto.fromUser(user: credentials.user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        try {
          final credentials = await _client.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          return Result.success(credentials.user == null ? null : UserDto.fromUser(user: credentials.user!));
        } on FirebaseAuthException catch (e) {
          return Result.failure(FormatException(e.message!));
        }
      } else {
        return Result.failure(FormatException(e.message!));
      }
    }
  }

  @override
  Stream<UserDto?> checkAuthChanges() {
    return _client.authStateChanges().map((final User? user) => user == null ? null : UserDto.fromUser(user: user));
  }

  @override
  UserDto? getCurrentUser() {
    final currentUser = _client.currentUser;
    if (currentUser != null) {
      return UserDto.fromUser(user: currentUser);
    }
    return null;
  }

  @override
  Future<void> logoutUser() {
    return _client.signOut();
  }
}
