import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/use_cases/crypt/handle_favorite_crypt_use_case.dart';
import 'package:wenia_test/domain/use_cases/crypt/listen_favorite_crypts_changes.dart';
import 'package:wenia_test/presentation/features/home/favorite/favorite_crypt_cubit.dart';
import 'favorite_crypt_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HandleFavoriteCryptUseCase>(),
  MockSpec<ListenFavoriteCryptsChanges>(),
])
void main() {
  group('FavoriteCryptCubitTests', () {
    late MockHandleFavoriteCryptUseCase mockHandleFavoriteCryptUseCase;
    late MockListenFavoriteCryptsChanges mockListenFavoriteCryptsChanges;
    late FavoriteCryptCubit cubit;
    const cryptModel = CryptModel(
      id: 'id',
      name: 'name',
      symbol: 'symbol',
      image: 'image',
      price: 1234,
      isFavorite: false,
    );

    setUp(() {
      mockHandleFavoriteCryptUseCase = MockHandleFavoriteCryptUseCase();
      mockListenFavoriteCryptsChanges = MockListenFavoriteCryptsChanges();
      cubit = FavoriteCryptCubit(mockListenFavoriteCryptsChanges, mockHandleFavoriteCryptUseCase);
    });

    test('Test getFavoriteCrypts is called correctly', () async {
      when(mockListenFavoriteCryptsChanges.invoke())
          .thenAnswer((_) => Stream.value([cryptModel]));

      final stream = (await cubit.getFavoriteCrypts().toList()).expand((element) => element);
      expect(stream.isEmpty, true);
      verify(mockListenFavoriteCryptsChanges.invoke()).called(1);
    });
  });
}