import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_tdd/core/errors/execptions.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/remote_data_source/remote_number_trivia_data_source.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/remote_data_source/retrofit/remote_number_retrofit.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([RemoteNumberRetrofit])
void main() {
  late MockRemoteNumberRetrofit numberRetrofit;
  late RemoteNumberTriviaDataSourceImpl remoteDataSource;

  setUp(() {
    numberRetrofit = MockRemoteNumberRetrofit();
    remoteDataSource =
        RemoteNumberTriviaDataSourceImpl(numberRetrofit: numberRetrofit);
  });
  const testModel = NumberTriviaModel(
      text: 'test text', number: 1, found: true, type: 'trivia');

  const testNumber = 1;

  group('getRandomNumberTrivia', () {
    test('should return NumberTriviaModel when call getRandomNumberTrivia',
        () async {
      when(numberRetrofit.getRandomTrivia())
          .thenAnswer((realInvocation) async => testModel);
      final result = await remoteDataSource.getRandomNumberTrivia();
      verify(numberRetrofit.getRandomTrivia());
      expect(result, testModel);
    });

    test('should throw ServerException when call getRandomTrivia', () async {
      when(numberRetrofit.getRandomTrivia()).thenThrow(Error());
      final result = remoteDataSource.getRandomNumberTrivia;
      expect(() => result(), throwsA(const TypeMatcher<ServerException>()));
      verify(numberRetrofit.getRandomTrivia());
    });
  });

  group('getConcreteNumberTrivia', () {
    test('should return numberTriviaModel when call getNumberTrivia', () async {
      when(numberRetrofit.getConcreteTrivia(any))
          .thenAnswer((realInvocation) async => testModel);
      final result = await remoteDataSource.getConcreteNumberTrivia(testNumber);
      verify(numberRetrofit.getConcreteTrivia(testNumber));
      expect(result, testModel);
    });

    test('should throw ServerException When call getNumberTrivia', () async {
      when(numberRetrofit.getConcreteTrivia(any)).thenThrow(Error());
      final call = remoteDataSource.getConcreteNumberTrivia;
      expect(() => call(testNumber),
          throwsA(const TypeMatcher<ServerException>()));
      verify(numberRetrofit.getConcreteTrivia(testNumber));
    });
  });
}
