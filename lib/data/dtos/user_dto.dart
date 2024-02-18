import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String name,
    required String photoURL,
  }) = _UserDto;

  factory UserDto.fromUser({required final User user}) {
    return UserDto(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoURL: user.photoURL ?? '',
    );
  }
}
