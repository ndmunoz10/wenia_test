import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/domain/use_cases/crypt/fetch_crypts_use_case.dart';

part 'comparison_crypt_cubit.freezed.dart';
part 'comparison_crypt_state.dart';

@injectable
class ComparisonCryptCubit extends Cubit<ComparisonCryptState> {
  ComparisonCryptCubit(this._fetchCryptsUseCase) : super(ComparisonCryptState.initial());

  final FetchCryptsUseCase _fetchCryptsUseCase;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _fetchCryptsUseCase.invoke(page: 1, perPage: 100);
    if (result.isSuccess) {
      emit(state.copyWith(crypts: result.data!, isLoading: false, errorMessage: null));
    } else {
      emit(state.copyWith(isLoading: false, errorMessage: (result.error as FormatException).message));
    }
  }

  void onLeftSelected(final CryptModel crypt) {
    emit(state.copyWith(leftCrypt: crypt));
  }

  void onRightSelected(final CryptModel crypt) {
    emit(state.copyWith(rightCrypt: crypt));
  }
}
