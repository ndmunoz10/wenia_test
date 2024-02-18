import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/domain/models/user_model.dart';
import 'package:wenia_test/domain/use_cases/auth/check_auth_changes_use_case.dart';
import 'package:wenia_test/presentation/features/auth/auth_cubit.dart';
import 'auth_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CheckAuthChangesUseCase>(),
])
void main() {
  group('AuthCubitTests', () {
    final mockCheckAuthChangesUseCase = MockCheckAuthChangesUseCase();
    late AuthCubit cubit;
    const user = UserModel(id: 'id', email: 'email', name: 'name', photoURL: 'photoURL');

    setUp(() {
      cubit = AuthCubit(mockCheckAuthChangesUseCase);
    });

    test('Test unauthenticated state when user is null', () async {
      when(mockCheckAuthChangesUseCase.invoke()).thenAnswer((_) => Stream.value(null));

      expect(cubit.state, const AuthState.uninitialized());
      await cubit.checkAuthChanges();
      cubit.stream.listen((state) {
        expect(state, const AuthState.unauthenticated());
      });
      verify(mockCheckAuthChangesUseCase.invoke()).called(1);
    });

    test('Test authenticated state when user is not null', () async {
      when(mockCheckAuthChangesUseCase.invoke()).thenAnswer((_) => Stream.value(user));

      expect(cubit.state, const AuthState.uninitialized());
      await cubit.checkAuthChanges();
      cubit.stream.listen((state) {
        expect(state, const AuthState.authenticated());
      });
      verify(mockCheckAuthChangesUseCase.invoke()).called(1);
    });
  });
}