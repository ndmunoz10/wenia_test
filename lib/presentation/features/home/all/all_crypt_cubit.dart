import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/use_cases/auth/logout_use_case.dart';
import 'package:wenia_test/domain/use_cases/crypt/listen_favorite_crypts_changes.dart';
import 'package:wenia_test/domain/use_cases/crypt/handle_favorite_crypt_use_case.dart';
import 'package:wenia_test/domain/use_cases/crypt/fetch_crypts_use_case.dart';

part 'all_crypt_cubit.freezed.dart';
part 'all_crypt_state.dart';

@injectable
class AllCryptCubit extends Cubit<AllCryptState> {
  AllCryptCubit(
      this._fetchCryptsUseCase, this._createFavoriteCryptUseCase, this._getFavoriteCrypts, this._logoutUseCase)
      : super(AllCryptState.initial());

  final HandleFavoriteCryptUseCase _createFavoriteCryptUseCase;
  final FetchCryptsUseCase _fetchCryptsUseCase;
  final ListenFavoriteCryptsChanges _getFavoriteCrypts;
  final LogoutUseCase _logoutUseCase;

  void init() {
    fetchCryptData();
    _listenForFavorites();
  }

  Future<void> fetchCryptData() async {
    emit(state.copyWith(isLoading: true));
    final result = await _fetchCryptsUseCase.invoke(page: state.page);
    if (result.isFailure) {
      emit(
        state.copyWith(
          errorMessage: (result.error! as FormatException).message,
          isLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          crypts: state.crypts + result.data!,
          filteredCrypts: state.crypts + result.data!,
          page: state.page + 1,
          isLoading: false,
          errorMessage: null,
        ),
      );
    }
  }

  void filterByText(final String inputText) {
    if (inputText.length >= 3) {
      emit(
        state.copyWith(
          filteredCrypts:
              state.crypts.where((crypt) => crypt.name.toLowerCase().contains(inputText.toLowerCase())).toList(),
        ),
      );
    } else if (inputText.isEmpty) {
      emit(
        state.copyWith(
          filteredCrypts: state.crypts,
        ),
      );
    }
  }

  void handleAsFavorite({required final CryptModel crypt}) {
    _createFavoriteCryptUseCase.invoke(crypt: crypt);
  }

  void logout() {
    _logoutUseCase.invoke();
  }

  void _listenForFavorites() {
    _getFavoriteCrypts.invoke().listen((crypts) {
      for (final favoriteCrypt in crypts) {
        emit(
          state.copyWith(
            crypts: state.crypts
                .map((crypt) =>
                    crypt.id == favoriteCrypt.id ? crypt.copyWith(isFavorite: favoriteCrypt.isFavorite) : crypt)
                .toList(),
            filteredCrypts: state.filteredCrypts
                .map((crypt) =>
                    crypt.id == favoriteCrypt.id ? crypt.copyWith(isFavorite: favoriteCrypt.isFavorite) : crypt)
                .toList(),
          ),
        );
      }
    });
  }
}
