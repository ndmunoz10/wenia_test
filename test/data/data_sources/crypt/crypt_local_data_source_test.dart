import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wenia_test/data/data_sources/crypt/crypt_local_data_source_impl.dart';
import 'package:wenia_test/data/entities/crypt_entity.dart';
import 'crypt_local_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CryptEntity>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
  MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
])
void main() {
  group('CryptLocalDataSourceTests', () {
    final mockFavoriteCryptEntity = MockCryptEntity();
    final mockNotFavoriteCryptEntity = MockCryptEntity();
    final mockFirestore = MockFirebaseFirestore();
    final mockCollection = MockCollectionReference();
    final mockDocument = MockDocumentReference();
    const userId = 'uid';
    final cryptLocalDataSource = CryptLocalDataSourceImpl(mockFirestore);
    when(mockFavoriteCryptEntity.id).thenReturn('cryptId');
    when(mockNotFavoriteCryptEntity.id).thenReturn('cryptId');
    when(mockFavoriteCryptEntity.isFavorite).thenReturn(true);
    when(mockNotFavoriteCryptEntity.isFavorite).thenReturn(false);

    test('Handle favorite crypt updates return error', () async {
      when(mockFirestore.collection(userId)).thenReturn(mockCollection);
      when(mockCollection.doc(mockFavoriteCryptEntity.id)).thenReturn(mockDocument);
      when(mockDocument.set(mockNotFavoriteCryptEntity.toJson()))
          .thenThrow(Exception('Some error'));

      final result = await cryptLocalDataSource.handleFavoriteCrypt(crypt: mockFavoriteCryptEntity, userId: userId);

      expect(result.isFailure, true);
      expect(result.error != null, true);
      verify(mockFirestore.collection(userId)).called(1);
    });

    test('Test get favorite crypts once returns successfully', () async {
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
      final mockQueryDocumentSnapshots = [mockQueryDocumentSnapshot];
      when(mockQueryDocumentSnapshot.data()).thenReturn({
        'id': 'uid',
        'name': 'name',
        'symbol': 'symbol',
        'image': 'image',
        'price': 123,
        'isFavorite': true,
      });
      when(mockQuerySnapshot.docs).thenReturn(mockQueryDocumentSnapshots);
      when(mockFirestore.collection(userId)).thenReturn(mockCollection);
      when(mockCollection.get()).thenAnswer((_) => Future.value(mockQuerySnapshot));

      final result = await cryptLocalDataSource.getFavoriteCryptsOnce(userId: userId);
      expect(result.isSuccess, true);
      expect(result.data!.first.id, 'uid');
    });

    test('Test get favorite crypts once returns with error', () async {
      when(mockFirestore.collection(userId)).thenReturn(mockCollection);
      when(mockCollection.get()).thenThrow(Exception('Some error'));

      final result = await cryptLocalDataSource.getFavoriteCryptsOnce(userId: userId);
      expect(result.isFailure, true);
      expect(result.error!.toString().contains('Some error'), true);
    });

    test('Test listen for favorites is called', () async {
      when(mockFirestore.collection(userId)).thenReturn(mockCollection);
      when(mockCollection.snapshots(includeMetadataChanges: true)).thenAnswer((_) => const Stream.empty());

      cryptLocalDataSource.listenFavoriteCryptChanges(userId: userId);
      verify(mockCollection.snapshots(includeMetadataChanges: true)).called(1);
    });
  });
}