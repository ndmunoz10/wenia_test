import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/use_cases/crypt/fetch_crypts_use_case.dart';
import 'package:wenia_test/presentation/features/home/comparison/comparison_crypt_cubit.dart';
import 'comparison_crypt_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FetchCryptsUseCase>()
])
void main() {
  group('ComparisonCryptCubitTests', () {
    late FetchCryptsUseCase mockFetchCryptsUseCase;
    late ComparisonCryptCubit cubit;
    const cryptModel = CryptModel(
      id: 'id',
      name: 'name',
      symbol: 'symbol',
      image: 'image',
      price: 1234,
      isFavorite: true,
    );

    setUp(() {
      mockFetchCryptsUseCase = MockFetchCryptsUseCase();
      cubit = ComparisonCryptCubit(mockFetchCryptsUseCase);
    });

    test('Test init is emitting states correctly', () async {
      when(mockFetchCryptsUseCase.invoke(page: 1, perPage: 100))
          .thenAnswer((_) => Future.value(Result.success([cryptModel])));

      await cubit.init();

      expect(cubit.state.crypts.length == 1, true);
      expect(cubit.state.crypts.first, cryptModel);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.errorMessage, null);
      verify(mockFetchCryptsUseCase.invoke(page: 1, perPage: 100)).called(1);
    });

    test('Test init is emitting states correctly', () async {
      when(mockFetchCryptsUseCase.invoke(page: 1, perPage: 100))
      .thenAnswer((_) => Future.value(Result.failure(const FormatException('Some error'))));

      await cubit.init();

      expect(cubit.state.crypts.isEmpty, true);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.errorMessage, 'Some error');
      verify(mockFetchCryptsUseCase.invoke(page: 1, perPage: 100)).called(1);
    });

    test('Test on select right is correct', () {
      cubit.onRightSelected(cryptModel);
      expect(cubit.state.rightCrypt, cryptModel);
      expect(cubit.state.leftCrypt, null);
    });

    test('Test on select left is correct', () {
      cubit.onLeftSelected(cryptModel);
      expect(cubit.state.leftCrypt, cryptModel);
      expect(cubit.state.rightCrypt, null);
    });
  });
}