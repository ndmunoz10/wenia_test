import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/use_cases/auth/check_auth_changes_use_case.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._checkAuthChangesUseCase) : super(const AuthState.uninitialized());

  final CheckAuthChangesUseCase _checkAuthChangesUseCase;

  Future<void> checkAuthChanges() async {
    await Future.delayed(const Duration(seconds: 2));
    _checkAuthChangesUseCase.invoke().listen((final UserModel? user) {
      if (user == null) {
        emit(const AuthState.unauthenticated());
      } else {
        emit(const AuthState.authenticated());
      }
    });
  }
}
