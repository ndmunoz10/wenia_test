import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wenia_test/data/dtos/crypt_dto.dart';
import 'package:wenia_test/data/entities/crypt_entity.dart';

part 'crypt_model.freezed.dart';

@freezed
class CryptModel with _$CryptModel {
  const factory CryptModel({
    required String id,
    required String name,
    required String symbol,
    required String image,
    required num price,
    required bool isFavorite,
  }) = _CryptModel;

  factory CryptModel.fromDto({
    required final CryptDto crypt,
    required final bool isFavorite,
  }) {
    return CryptModel(
      id: crypt.id,
      name: crypt.name,
      symbol: crypt.symbol,
      image: crypt.image,
      price: crypt.price,
      isFavorite: isFavorite,
    );
  }

  factory CryptModel.fromEntity({required final CryptEntity crypt}) {
    return CryptModel(
      id: crypt.id,
      name: crypt.name,
      symbol: crypt.symbol,
      image: crypt.image,
      price: crypt.price,
      isFavorite: crypt.isFavorite,
    );
  }
}
