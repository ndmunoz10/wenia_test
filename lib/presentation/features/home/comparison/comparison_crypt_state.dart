part of 'comparison_crypt_cubit.dart';

@freezed
class ComparisonCryptState with _$ComparisonCryptState {
  const factory ComparisonCryptState({
    required List<CryptModel> crypts,
    required bool isLoading,
    final CryptModel? leftCrypt,
    final CryptModel? rightCrypt,
    String? errorMessage,
  }) = _ComparisonCryptState;

  factory ComparisonCryptState.initial() {
    return const ComparisonCryptState(
      crypts: [],
      isLoading: false,
    );
  }
}
