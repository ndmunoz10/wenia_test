import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_local_data_source.dart';
import 'package:wenia_test/data/entities/crypt_entity.dart';

class CryptLocalDataSourceImpl extends CryptLocalDataSource {
  CryptLocalDataSourceImpl(this._client);

  final FirebaseFirestore _client;

  @override
  Future<Result<String>> handleFavoriteCrypt({
    required final CryptEntity crypt,
    required final String userId,
  }) async {
    try {
      _client.collection(userId).doc(crypt.id).set(
            crypt.copyWith(isFavorite: !crypt.isFavorite).toJson(),
          );
      return Result.success(crypt.id);
    } catch (e) {
      return Result.failure(FormatException(e.toString()));
    }
  }

  @override
  Future<Result<List<CryptEntity>>> getFavoriteCryptsOnce({
    required String userId,
  }) async {
    try {
      final documents = (await _client.collection(userId).get()).docs;
      return Result.success(
        documents.map((documentSnapshot) => CryptEntity.fromJson(documentSnapshot.data())).toList(),
      );
    } catch (e) {
      return Result.failure(FormatException(e.toString()));
    }
  }

  @override
  Stream<List<CryptEntity>> listenFavoriteCryptChanges({
    required String userId,
  }) {
    return _client.collection(userId).snapshots(includeMetadataChanges: true).map((snapshot) {
      final docs = snapshot.docs;
      return docs.map((documentSnapshot) => CryptEntity.fromJson(documentSnapshot.data())).toList();
    });
  }
}
