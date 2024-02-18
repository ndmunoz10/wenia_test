import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/use_cases/crypt/handle_favorite_crypt_use_case.dart';
import 'package:wenia_test/domain/use_cases/crypt/listen_favorite_crypts_changes.dart';

@injectable
class FavoriteCryptCubit {
  FavoriteCryptCubit(this._listenFavoriteCryptsChanges, this._handleFavoriteCryptUseCase);

  final HandleFavoriteCryptUseCase _handleFavoriteCryptUseCase;
  final ListenFavoriteCryptsChanges _listenFavoriteCryptsChanges;

  Stream<List<CryptModel>> getFavoriteCrypts() {
    return _listenFavoriteCryptsChanges.invoke().map((crypts) {
      return crypts.where((crypt) => crypt.isFavorite).toList();
    });
  }

  void handleAsFavorite({required final CryptModel crypt}) {
    _handleFavoriteCryptUseCase.invoke(crypt: crypt);
  }
}
