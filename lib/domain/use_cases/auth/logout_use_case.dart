import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';

@injectable
class LogoutUseCase {
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  void invoke() {
    _authRepository.logoutUser();
  }
}
