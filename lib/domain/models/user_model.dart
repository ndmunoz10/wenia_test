import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wenia_test/data/dtos/user_dto.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    required String photoURL,
  }) = _UserModel;

  factory UserModel.fromDto({required final UserDto user}) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      photoURL: user.photoURL,
    );
  }
}
