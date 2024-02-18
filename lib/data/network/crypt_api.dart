import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wenia_test/core/config.dart';
import 'package:wenia_test/data/dtos/crypt_dto.dart';

part 'crypt_api.g.dart';

@injectable
@RestApi()
abstract class CryptApi {
  @factoryMethod
  factory CryptApi(Dio dio) {
    return _CryptApi(
      dio,
      baseUrl: config.baseUrl,
    );
  }

  @GET('/coins/markets')
  Future<List<CryptDto>> fetchCryptsPaginated({
    @Query('vs_currency') String currency = 'usd',
    @Query('order') String order = 'market_cap_desc',
    @Query('per_page') required int perPage,
    @Query('page') required int page,
  });
}
