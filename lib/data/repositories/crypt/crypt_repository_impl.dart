import 'package:collection/collection.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_local_data_source.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_remote_data_source.dart';
import 'package:wenia_test/data/dtos/crypt_dto.dart';
import 'package:wenia_test/data/entities/crypt_entity.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/repositories/crypt/crypt_repository.dart';

class CryptRepositoryImpl extends CryptRepository {
  CryptRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final CryptRemoteDataSource _remoteDataSource;
  final CryptLocalDataSource _localDataSource;

  @override
  Future<Result<String>> handleFavoriteCrypt({
    required final CryptModel crypt,
    required final String userId,
  }) {
    return _localDataSource.handleFavoriteCrypt(
      crypt: CryptEntity.fromModel(crypt: crypt),
      userId: userId,
    );
  }

  @override
  Future<Result<List<CryptModel>>> fetchCrypts({
    required int page,
    required int perPage,
    required String userId,
  }) async {
    final favoriteCrypts = (await _localDataSource.getFavoriteCryptsOnce(userId: userId)).dataOrElse([]);
    return _remoteDataSource.fetchCrypts(page: page, perPage: perPage).then((final Result<List<CryptDto>> result) {
      return result.map((final List<CryptDto> crypts) {
        return crypts.map((final CryptDto crypt) {
          final isFavorite =
              favoriteCrypts.firstWhereOrNull((favoriteCrypt) => favoriteCrypt.id == crypt.id)?.isFavorite ?? false;
          return CryptModel.fromDto(
            crypt: crypt,
            isFavorite: isFavorite,
          );
        }).toList();
      });
    });
  }

  @override
  Stream<List<CryptModel>> listenFavoriteCryptsChanges({required String userId}) {
    return _localDataSource.listenFavoriteCryptChanges(userId: userId).map((cryptEntities) {
      return cryptEntities.map((crypt) => CryptModel.fromEntity(crypt: crypt)).toList();
    });
  }
}
