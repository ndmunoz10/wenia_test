import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_local_data_source_impl.dart';
import 'package:wenia_test/data/entities/crypt_entity.dart';

@injectable
abstract class CryptLocalDataSource {
  Future<Result<String>> handleFavoriteCrypt({
    required final CryptEntity crypt,
    required final String userId,
  });

  Stream<List<CryptEntity>> listenFavoriteCryptChanges({
    required String userId,
  });

  Future<Result<List<CryptEntity>>> getFavoriteCryptsOnce({
    required String userId,
  });

  @factoryMethod
  static CryptLocalDataSource create(final FirebaseFirestore client) => CryptLocalDataSourceImpl(client);
}
