import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/data/data_sources/auth/auth_remote_data_source_impl.dart';
import 'package:wenia_test/data/dtos/user_dto.dart';
import 'auth_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<User>(),
  MockSpec<FirebaseAuth>(),
  MockSpec<UserCredential>(),
])
void main() {
  group('AuthRemoteDataSourceTests', () {
    final mockUser = MockUser();
    final mockFirebaseAuth = MockFirebaseAuth();
    final authRemoteDataSource = AuthRemoteDataSourceImpl(mockFirebaseAuth);

    test('Test get current user is null', () {
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      expect(authRemoteDataSource.getCurrentUser(), null);
    });

    test('Test get current user is not null', () {
      when(mockUser.uid).thenReturn('uid');
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      expect(
        authRemoteDataSource.getCurrentUser(),
        const UserDto(
          id: 'uid',
          email: '',
          name: '',
          photoURL: '',
        ),
      );
    });

    test('Test logout is called', () {
      authRemoteDataSource.logoutUser();
      verify(mockFirebaseAuth.signOut()).called(1);
    });

    test('Test authStateChanges is called', () {
      authRemoteDataSource.checkAuthChanges();
      verify(mockFirebaseAuth.authStateChanges()).called(1);
    });

    test('Test create new user successfully', () async {
      const email = 'email';
      const password = 'password';
      final mockCredentials = MockUserCredential();
      when(mockUser.uid).thenReturn('uid');
      when(mockCredentials.user).thenReturn(mockUser);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) => Future.value(mockCredentials));

      final result = await authRemoteDataSource.authUser(email: email, password: password);
      expect(result.isSuccess, true);
      expect(result.data!.id, 'uid');
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
    });

    test('Test create existing user', () async {
      const email = 'email';
      const password = 'password';
      final mockCredentials = MockUserCredential();
      when(mockUser.uid).thenReturn('uid');
      when(mockCredentials.user).thenReturn(mockUser);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenThrow(FirebaseAuthException(code: 'email-already-in-use'));
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
      .thenAnswer((_) => Future.value(mockCredentials));

      final result = await authRemoteDataSource.authUser(email: email, password: password);
      expect(result.isSuccess, true);
      expect(result.data!.id, 'uid');
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
      verify(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password)).called(1);
    });

    test('Test create user with short password', () async {
      const email = 'email';
      const password = '1234';
      final mockCredentials = MockUserCredential();
      when(mockUser.uid).thenReturn('uid');
      when(mockCredentials.user).thenReturn(mockUser);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenThrow(FirebaseAuthException(code: 'password-too-short', message: 'Some error'));

      final result = await authRemoteDataSource.authUser(email: email, password: password);
      expect(result.isFailure, true);
      expect(result.error != null, true);
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
    });
  });
}