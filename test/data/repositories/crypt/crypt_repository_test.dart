import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_local_data_source.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_remote_data_source.dart';
import 'package:wenia_test/data/dtos/crypt_dto.dart';
import 'package:wenia_test/data/entities/crypt_entity.dart';
import 'package:wenia_test/data/repositories/crypt/crypt_repository_impl.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';

import 'crypt_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CryptRemoteDataSource>(),
  MockSpec<CryptLocalDataSource>(),
])
void main() {
  group('CryptRepositoryTests', () {
    final mockRemoteDataSource = MockCryptRemoteDataSource();
    final mockLocalDataSource = MockCryptLocalDataSource();
    const cryptModel = CryptModel(
      id: 'id',
      name: 'name',
      symbol: 'symbol',
      image: 'image',
      price: 1234,
      isFavorite: true,
    );
    const userId = 'userId';
    final cryptEntity = CryptEntity.fromModel(crypt: cryptModel);
    const cryptDto = CryptDto(
      id: 'id',
      name: 'name',
      symbol: 'symbol',
      image: 'image',
      price: 1234,
    );
    final repository = CryptRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
    test('Test handle favorite crypt is called correctly', () {
      when(mockLocalDataSource.handleFavoriteCrypt(crypt: cryptEntity, userId: userId))
          .thenAnswer((_) => Future.value(Result.success(cryptEntity.id)));

      repository.handleFavoriteCrypt(crypt: cryptModel, userId: userId);
      verify(mockLocalDataSource.handleFavoriteCrypt(crypt: cryptEntity, userId: userId)).called(1);
    });

    test('Test fetch crypts successfully', () async {
      when(mockLocalDataSource.getFavoriteCryptsOnce(userId: userId))
          .thenAnswer((_) => Future.value(Result.success([cryptEntity])));
      when(mockRemoteDataSource.fetchCrypts(page: 1, perPage: 15))
          .thenAnswer((_) => Future.value(Result.success([cryptDto])));

      final result = await repository.fetchCrypts(page: 1, perPage: 15, userId: userId);
      expect(result.isSuccess, true);
      expect(result.data!.first, cryptModel);
      verify(mockLocalDataSource.getFavoriteCryptsOnce(userId: userId)).called(1);
      verify(mockRemoteDataSource.fetchCrypts(page: 1, perPage: 15)).called(1);
    });

    test('Test listen for favorite changes is called', () {
      when(mockLocalDataSource.listenFavoriteCryptChanges(userId: userId))
          .thenAnswer((_) => Stream.value([cryptEntity]));

      repository.listenFavoriteCryptsChanges(userId: userId).listen((crypt) {
        expect(crypt, [cryptModel]);
      });
      verify(mockLocalDataSource.listenFavoriteCryptChanges(userId: userId)).called(1);
    });
  });
}