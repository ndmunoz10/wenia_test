import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/repositories/crypt/crypt_repository.dart';

@injectable
class ListenFavoriteCryptsChanges {
  ListenFavoriteCryptsChanges(this._authRepository, this._cryptRepository);

  final AuthRepository _authRepository;
  final CryptRepository _cryptRepository;

  Stream<List<CryptModel>> invoke() {
    final userId = _authRepository.getCurrentUser()?.id;
    if (userId != null) {
      return _cryptRepository.listenFavoriteCryptsChanges(userId: userId);
    }
    return const Stream.empty();
  }
}
