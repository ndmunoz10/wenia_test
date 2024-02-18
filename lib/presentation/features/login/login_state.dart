part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.idle() = _Idle;

  const factory LoginState.loading() = _Loading;

  const factory LoginState.error({required final String message}) = _Error;
}
