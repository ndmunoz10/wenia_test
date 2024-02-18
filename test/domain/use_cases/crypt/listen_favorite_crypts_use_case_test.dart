import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/repositories/auth/auth_repository.dart';
import 'package:wenia_test/domain/repositories/crypt/crypt_repository.dart';
import 'package:wenia_test/domain/use_cases/crypt/listen_favorite_crypts_changes.dart';

import 'listen_favorite_crypts_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CryptRepository>(),
  MockSpec<AuthRepository>(),
])
void main() {
  group('ListenFavoriteCryptsChangesTests', () {
    final mockCryptRepository = MockCryptRepository();
    final mockAuthRepository = MockAuthRepository();
    final useCase = ListenFavoriteCryptsChanges(mockAuthRepository, mockCryptRepository);
    const userModel = UserModel(id: 'id', email: 'email', name: 'name', photoURL: 'photoURL');
    const cryptModel = CryptModel(
      id: 'id',
      name: 'name',
      symbol: 'symbol',
      image: 'image',
      price: 1234,
      isFavorite: false,
    );

    test('Test listen for favorite crypts when userId is null', () async {
      when(mockAuthRepository.getCurrentUser()).thenReturn(null);

      final result = useCase.invoke();
      expect(await result.isEmpty, true);
      verify(mockAuthRepository.getCurrentUser()).called(1);
    });

    test('Test listen for favorite crypts when userId is not null', () async {
      when(mockAuthRepository.getCurrentUser()).thenReturn(userModel);
      when(mockCryptRepository.listenFavoriteCryptsChanges(userId: userModel.id))
          .thenAnswer((_) => Stream.value([cryptModel]));

      useCase.invoke().listen((crypt) {
        expect(crypt, [cryptModel]);
      });
      verify(mockAuthRepository.getCurrentUser()).called(1);
      verify(mockCryptRepository.listenFavoriteCryptsChanges(userId: userModel.id)).called(1);
    });
  });
}
