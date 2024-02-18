import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';

part 'crypt_entity.freezed.dart';
part 'crypt_entity.g.dart';

@freezed
class CryptEntity with _$CryptEntity {
  const factory CryptEntity({
    required String id,
    required String name,
    required String symbol,
    required String image,
    required num price,
    required bool isFavorite,
  }) = _CryptEntity;

  factory CryptEntity.fromModel({required final CryptModel crypt}) {
    return CryptEntity(
      id: crypt.id,
      name: crypt.name,
      symbol: crypt.symbol,
      image: crypt.image,
      price: crypt.price,
      isFavorite: crypt.isFavorite,
    );
  }

  factory CryptEntity.fromJson(Map<String, dynamic> json) => _$CryptEntityFromJson(json);
}
