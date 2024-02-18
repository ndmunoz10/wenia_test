import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/use_cases/auth/login_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(const LoginState.idle());

  final LoginUseCase _loginUseCase;

  Future<void> authUser(final String email, final String password) async {
    emit(const LoginState.loading());
    final result = await _loginUseCase.invoke(email, password);
    if (result.isFailure) {
      emit(LoginState.error(message: (result.error! as FormatException).message));
    }
    emit(const LoginState.idle());
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Email cannot be empty';
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return 'Incorrect email format';
    }
    return null;
  }
}
