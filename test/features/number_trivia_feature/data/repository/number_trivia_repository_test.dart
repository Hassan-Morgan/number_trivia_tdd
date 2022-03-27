import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_tdd/core/errors/execptions.dart';
import 'package:number_trivia_app_tdd/core/errors/failures.dart';
import 'package:number_trivia_app_tdd/core/network_info/network_info.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/local_data_source/local_number_trivia_data_source.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/remote_data_source/remote_number_trivia_data_source.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';

import 'number_trivia_repository_test.mocks.dart';

@GenerateMocks(
    [NetworkInfo, RemoteNumberTriviaDataSource, LocalNumberTriviaDataSource])
void main() {
  late MockNetworkInfo networkInfo;
  late MockRemoteNumberTriviaDataSource remoteSource;
  late MockLocalNumberTriviaDataSource localSource;
  late NumberTriviaDataRepository repository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteSource = MockRemoteNumberTriviaDataSource();
    localSource = MockLocalNumberTriviaDataSource();
    repository = NumberTriviaDataRepository(
      remoteNumberTriviaDataSource: remoteSource,
      localNumberTriviaDataSource: localSource,
      networkInfo: networkInfo,
    );
  });
  const testNumber = 1;
  const testModel = NumberTriviaModel(
      text: 'test model', number: testNumber, found: true, type: 'trivia');
  const testEntity = NumberTriviaEntity(text: 'test model', number: testNumber);

  group('getConcreteNumberTrivia', () {
    group('when online', () {
      setUp(() {
        when(networkInfo.getCurrentConnectionState)
            .thenAnswer((realInvocation) async => true);
      });
      test('should return remote data when call the getConcreteNumberTrivia',
          () async {
        when(remoteSource.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => testModel);
        final remoteResult =
            await repository.getConcreteNumberTrivia(testNumber);
        expect(remoteResult, const Right(testEntity));
        verify(remoteSource.getConcreteNumberTrivia(testNumber));
        verify(localSource.setNumberTrivia(testModel));
      });

      test(
          'should return ServerFailure when call the getConcreteNumberTrivia and get ServerException',
          () async {
        when(remoteSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        final remoteResult =
            await repository.getConcreteNumberTrivia(testNumber);
        expect(remoteResult, Left(ServerFailure()));
        verify(remoteSource.getConcreteNumberTrivia(testNumber));
        verifyZeroInteractions(localSource);
      });
    });
    group('when offline', () {
      setUp(() {
        when(networkInfo.getCurrentConnectionState)
            .thenAnswer((realInvocation) async => false);
      });
      test(
          'should call the getLocalNumberTrivia when call the getConcreteNumberTrivia',
          () async {
        when(localSource.getNumberTrivia())
            .thenAnswer((realInvocation) async => testModel);
        final localResult =
            await repository.getConcreteNumberTrivia(testNumber);
        verify(localSource.getNumberTrivia());
        expect(localResult, const Right(testEntity));
      });

      test(
          'should return CashFailure when call the getConcreteNumberTrivia and get ServerException',
          () async {
        when(localSource.getNumberTrivia()).thenThrow(CashException());
        final localResult =
            await repository.getConcreteNumberTrivia(testNumber);
        verify(localSource.getNumberTrivia());
        verifyZeroInteractions(remoteSource);
        expect(localResult, Left(CashFailure()));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    group('when online', () {
      setUp(() {
        when(networkInfo.getCurrentConnectionState)
            .thenAnswer((realInvocation) async => true);
      });

      test('should return remote data when call the getRandomNumberTrivia',
          () async {
        when(remoteSource.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => testModel);
        final result = await repository.getRandomNumberTrivia();
        verify(networkInfo.getCurrentConnectionState);
        expect(result, const Right(testEntity));
        verify(remoteSource.getRandomNumberTrivia());
        verify(localSource.setNumberTrivia(testModel));
      });

      test(
          'should return ServerFailure when call the getRandomNumberTrivia throw serverException',
          () async {
        when(remoteSource.getRandomNumberTrivia()).thenThrow(ServerException());
        final result = await repository.getRandomNumberTrivia();
        expect(result, Left(ServerFailure()));
        verify(remoteSource.getRandomNumberTrivia());
        verifyZeroInteractions(localSource);
      });
    });
    group('when offline', () {
      setUp(() {
        when(networkInfo.getCurrentConnectionState)
            .thenAnswer((realInvocation) async => false);
      });

      test('should return local data when call the getRandomNumberTrivia',
          () async {
        when(localSource.getNumberTrivia())
            .thenAnswer((realInvocation) async => testModel);
        final result = await repository.getRandomNumberTrivia();
        expect(result, const Right(testEntity));
        verify(localSource.getNumberTrivia());
        verifyZeroInteractions(remoteSource);
      });

      test(
          'should return LocalFailure when call the getRandomNumberTrivia throw CashException',
          () async {
        when(localSource.getNumberTrivia()).thenThrow(CashException());
        final result = await repository.getRandomNumberTrivia();
        expect(result, Left(CashFailure()));
        verify(localSource.getNumberTrivia());
        verifyZeroInteractions(remoteSource);
      });
    });
  });
}
