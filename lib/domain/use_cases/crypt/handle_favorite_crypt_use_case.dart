import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/repositories/crypt/crypt_repository.dart';

@injectable
class HandleFavoriteCryptUseCase {
  HandleFavoriteCryptUseCase(this._cryptRepository, this._authRepository);

  final CryptRepository _cryptRepository;
  final AuthRepository _authRepository;

  Future<Result<String>> invoke({
    required final CryptModel crypt,
  }) async {
    final currentUserId = _authRepository.getCurrentUser()?.id;
    if (currentUserId != null) {
      return await _cryptRepository.handleFavoriteCrypt(crypt: crypt, userId: currentUserId);
    }
    await _authRepository.logoutUser();
    return Result.failure(const FormatException('User is not logged in'));
  }
}
