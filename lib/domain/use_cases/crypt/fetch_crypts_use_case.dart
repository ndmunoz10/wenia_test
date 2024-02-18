import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/repositories/crypt/crypt_repository.dart';

@injectable
class FetchCryptsUseCase {
  FetchCryptsUseCase(this._cryptRepository, this._authRepository);

  final CryptRepository _cryptRepository;
  final AuthRepository _authRepository;

  Future<Result<List<CryptModel>>> invoke({
    required final int page,
    final int? perPage,
  }) async {
    final userId = _authRepository.getCurrentUser()?.id;
    if (userId != null) {
      final actualPerPage = perPage ?? 15;
      return _cryptRepository.fetchCrypts(page: page, perPage: actualPerPage, userId: userId);
    }
    await _authRepository.logoutUser();
    return Result.failure(const FormatException('User is not logged in'));
  }
}
