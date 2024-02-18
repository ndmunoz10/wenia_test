import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/use_cases/auth/login_use_case.dart';
import 'package:wenia_test/presentation/features/login/login_cubit.dart';
import 'login_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginUseCase>(),
])
void main() {
  group('LoginCubitTests', () {
    late MockLoginUseCase mockLoginUseCase;
    late LoginCubit cubit;
    const email = 'email';
    const password = 'password';
    const user = UserModel(id: 'id', email: 'email', name: 'name', photoURL: 'photoURL');

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      cubit = LoginCubit(mockLoginUseCase);
    });

    test('Test email is null and empty', () {
      expect(cubit.emailValidator('') != null, true);
      expect(cubit.emailValidator(null) != null, true);
    });

    test('Test email has incorrect format', () {
      expect(cubit.emailValidator('hello@hello@com') != null, true);
    });

    test('Test email is correct', () {
      expect(cubit.emailValidator('hello@hello.com') != null, false);
    });

    test('Test login successful', () async {
      when(mockLoginUseCase.invoke(email, password))
          .thenAnswer((_) => Future.value(Result.success(user)));

      expect(cubit.state, const LoginState.idle());
      await cubit.authUser(email, password);
      expect(cubit.state, const LoginState.idle());
      verify(mockLoginUseCase.invoke(email, password)).called(1);
    });
  });
}