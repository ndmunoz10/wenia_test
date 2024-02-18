import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/use_cases/auth/logout_use_case.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>()
])
void main() {
  group('LogoutUseCaseTests', () {
    final mockAuthRepository = MockAuthRepository();
    final useCase = LogoutUseCase(mockAuthRepository);

    test('Test logout is called', () {
      useCase.invoke();
      verify(mockAuthRepository.logoutUser()).called(1);
    });
  });
}