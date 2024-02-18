import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/repositories/crypt/crypt_repository.dart';
import 'package:wenia_test/domain/use_cases/crypt/fetch_crypts_use_case.dart';

import 'fetch_crypts_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CryptRepository>(),
  MockSpec<AuthRepository>(),
])
void main() {
  group('FetchCryptsUseCaseTests', () {
    final mockCryptRepository = MockCryptRepository();
    final mockAuthRepository = MockAuthRepository();
    final useCase = FetchCryptsUseCase(mockCryptRepository, mockAuthRepository);
    const userModel = UserModel(id: 'id', email: 'email', name: 'name', photoURL: 'photoURL');

    test('Test fetch crypts when userId is null', () async {
      when(mockAuthRepository.getCurrentUser()).thenReturn(null);

      final result = await useCase.invoke(page: 1);
      expect(result.isFailure, true);
      verify(mockAuthRepository.getCurrentUser()).called(1);
      verify(mockAuthRepository.logoutUser()).called(1);
    });

    test('Test fetch crypts when userId is not null', () async {
      when(mockAuthRepository.getCurrentUser()).thenReturn(userModel);
      when(mockCryptRepository.fetchCrypts(page: 1, perPage: 15, userId: userModel.id))
          .thenAnswer((_) => Future.value(Result.success([])));

      final result = await useCase.invoke(page: 1);
      expect(result.isSuccess, true);
      expect(result.data!, []);
      verify(mockAuthRepository.getCurrentUser()).called(1);
      verify(mockCryptRepository.fetchCrypts(page: 1, perPage: 15, userId: userModel.id)).called(1);
    });
  });
}
