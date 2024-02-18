import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_local_data_source.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_remote_data_source.dart';
import 'package:wenia_test/data/repositories/crypt/crypt_repository_impl.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';

@lazySingleton
abstract class CryptRepository {
  Future<Result<String>> handleFavoriteCrypt({
    required final CryptModel crypt,
    required final String userId,
  });

  Future<Result<List<CryptModel>>> fetchCrypts({
    required int page,
    required int perPage,
    required String userId,
  });

  Stream<List<CryptModel>> listenFavoriteCryptsChanges({
    required String userId,
  });

  @factoryMethod
  static CryptRepository create({
    required final CryptRemoteDataSource remoteDataSource,
    required final CryptLocalDataSource localDataSource,
  }) =>
      CryptRepositoryImpl(remoteDataSource, localDataSource);
}
