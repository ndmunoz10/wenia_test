import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_remote_data_source.dart';
import 'package:wenia_test/data/dtos/crypt_dto.dart';
import 'package:wenia_test/data/network/crypt_api.dart';

class CryptRemoteDataSourceImpl extends CryptRemoteDataSource {
  CryptRemoteDataSourceImpl(this._api);

  final CryptApi _api;

  @override
  Future<Result<List<CryptDto>>> fetchCrypts({
    required final int page,
    required final int perPage,
  }) async {
    try {
      final crypts = await _api.fetchCryptsPaginated(page: page, perPage: perPage);
      return Result.success(crypts);
    } catch (e) {
      return Result.failure(FormatException(e.toString()));
    }
  }
}
