import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/use_cases/auth/login_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>()
])
void main() {
  group('LoginUseCaseTests', () {
    final mockAuthRepository = MockAuthRepository();
    final useCase = LoginUseCase(mockAuthRepository);
    const email = 'email';
    const password = 'password';

    test('Test login is called', () {
      useCase.invoke(email, password);
      verify(mockAuthRepository.authUser(email: email, password: password)).called(1);
    });
  });
}
