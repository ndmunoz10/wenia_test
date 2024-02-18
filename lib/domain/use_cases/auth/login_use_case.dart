import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';

@injectable
class LoginUseCase {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Result<UserModel?>> invoke(final String email, final String password) {
    return _authRepository.authUser(email: email, password: password);
  }
}
