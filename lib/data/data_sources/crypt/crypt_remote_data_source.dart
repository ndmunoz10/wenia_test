import 'package:injectable/injectable.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_remote_data_source_impl.dart';
import 'package:wenia_test/data/dtos/crypt_dto.dart';
import 'package:wenia_test/data/network/crypt_api.dart';

@lazySingleton
abstract class CryptRemoteDataSource {
  Future<Result<List<CryptDto>>> fetchCrypts({
    required final int page,
    required final int perPage,
  });

  @factoryMethod
  static CryptRemoteDataSource create(final CryptApi api) => CryptRemoteDataSourceImpl(api);
}
