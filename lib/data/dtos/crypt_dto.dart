import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypt_dto.freezed.dart';
part 'crypt_dto.g.dart';

@freezed
class CryptDto with _$CryptDto {
  const factory CryptDto({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'image') required String image,
    @JsonKey(name: 'current_price') required num price,
  }) = _CryptDto;

  const CryptDto._();

  factory CryptDto.fromJson(Map<String, dynamic> json) => _$CryptDtoFromJson(json);
}
