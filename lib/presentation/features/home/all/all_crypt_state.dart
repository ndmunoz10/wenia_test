part of 'all_crypt_cubit.dart';

@freezed
class AllCryptState with _$AllCryptState {
  const factory AllCryptState({
    required List<CryptModel> crypts,
    required List<CryptModel> filteredCrypts,
    required int page,
    required bool isLoading,
    required String inputText,
    String? errorMessage,
  }) = _AllCryptState;

  factory AllCryptState.initial() {
    return const AllCryptState(
      crypts: [],
      filteredCrypts: [],
      page: 1,
      isLoading: false,
      inputText: '',
    );
  }
}
