import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';

@injectable
class CheckAuthChangesUseCase {
  CheckAuthChangesUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Stream<UserModel?> invoke() {
    return _authRepository.checkAuthChanges();
  }
}
