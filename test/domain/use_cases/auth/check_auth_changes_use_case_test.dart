import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/use_cases/auth/check_auth_changes_use_case.dart';
import 'check_auth_changes_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>()
])
void main() {
  group('CheckAuthChangesUseCaseTests', () {
    final mockAuthRepository = MockAuthRepository();
    final useCase = CheckAuthChangesUseCase(mockAuthRepository);

    test('Test auth changes is called correctly', () {
      useCase.invoke();
      verify(mockAuthRepository.checkAuthChanges()).called(1);
    });
  });
}