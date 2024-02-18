import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/core/results.dart';
import 'package:wenia_test/data/data_sources/auth/auth_remote_data_source.dart';
import 'package:wenia_test/data/dtos/user_dto.dart';
import 'package:wenia_test/data/repositories/auth/auth_repository_impl.dart';
import 'package:wenia_test/domain/models/user_model.dart';

import 'auth_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRemoteDataSource>(),
  MockSpec<UserDto>(),
])
void main() {
  group('AuthRepositoryTests', () {
    final mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(mockAuthRemoteDataSource);
    const email = 'email';
    const password = 'password';
    const userDto = UserDto(id: 'id', email: 'email', name: 'name', photoURL: 'photoURL');
    final userModel = UserModel.fromDto(user: userDto);
    test('Test auth user is mapping correctly', () async {
      when(mockAuthRemoteDataSource.authUser(email: email, password: password))
          .thenAnswer((_) => Future.value(Result.success(userDto)));

      final result = await authRepository.authUser(email: email, password: password);
      expect(result.isSuccess, true);
      expect(result.data!, userModel);
    });

    test('Test auth changes is called', () async {
      when(mockAuthRemoteDataSource.checkAuthChanges()).thenAnswer((_) => Stream.value(userDto));

      authRepository.checkAuthChanges().listen((user) => expect(user, userModel));
      verify(mockAuthRemoteDataSource.checkAuthChanges()).called(1);
    });

    test('Test get current user when it\'s null', () async {
      when(mockAuthRemoteDataSource.getCurrentUser()).thenReturn(null);

      final result = authRepository.getCurrentUser();
      expect(result, null);
      verify(mockAuthRemoteDataSource.getCurrentUser()).called(1);
    });

    test('Test get current user when it\'s not null', () async {
      when(mockAuthRemoteDataSource.getCurrentUser()).thenReturn(userDto);

      final result = authRepository.getCurrentUser();
      expect(result, userModel);
      verify(mockAuthRemoteDataSource.getCurrentUser()).called(1);
    });

    test('Test logout is called', () async {
      authRepository.logoutUser();
      verify(mockAuthRemoteDataSource.logoutUser()).called(1);
    });
  });
}