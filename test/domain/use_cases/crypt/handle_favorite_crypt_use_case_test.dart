import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/repositories/crypt/crypt_repository.dart';
import 'package:wenia_test/domain/use_cases/crypt/handle_favorite_crypt_use_case.dart';
import 'handle_favorite_crypt_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CryptRepository>(),
  MockSpec<AuthRepository>(),
])
void main() {
  group('HandleFavoriteCryptUseCaseTests', () {
    final mockCryptRepository = MockCryptRepository();
    final mockAuthRepository = MockAuthRepository();
    final useCase = HandleFavoriteCryptUseCase(mockCryptRepository, mockAuthRepository);
    const userModel = UserModel(id: 'id', email: 'email', name: 'name', photoURL: 'photoURL');
    const cryptModel = CryptModel(
      id: 'id',
      name: 'name',
      symbol: 'symbol',
      image: 'image',
      price: 1234,
      isFavorite: true,
    );

    test('Test handle favorite crypt when userId is null', () async {
      when(mockAuthRepository.getCurrentUser()).thenReturn(null);

      final result = await useCase.invoke(crypt: cryptModel);
      expect(result.isFailure, true);
      verify(mockAuthRepository.getCurrentUser()).called(1);
      verify(mockAuthRepository.logoutUser()).called(1);
    });

    test('Test handle favorite crypt when userId is not null', () async {
      when(mockAuthRepository.getCurrentUser()).thenReturn(userModel);
      when(mockCryptRepository.handleFavoriteCrypt(crypt: cryptModel, userId: userModel.id))
          .thenAnswer((_) => Future.value(Result.success(cryptModel.id)));

      final result = await useCase.invoke(crypt: cryptModel);
      expect(result.isSuccess, true);
      expect(result.data!, cryptModel.id);
      verify(mockAuthRepository.getCurrentUser()).called(1);
      verify(mockCryptRepository.handleFavoriteCrypt(crypt: cryptModel, userId: userModel.id)).called(1);
    });
  });
}