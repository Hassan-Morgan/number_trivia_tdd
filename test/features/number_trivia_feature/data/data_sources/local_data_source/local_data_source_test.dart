import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_tdd/core/errors/execptions.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/local_data_source/local_number_trivia_data_source.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../fixtures/fixtures_reader.dart';
import 'local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences sharedPreferences;
  late LocalNumberTriviaDataSourceImpl localSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localSource = LocalNumberTriviaDataSourceImpl(sharedPreferences);
  });
  String testJson = fixtureReader('number_trivia_json.json');
  const testModel = NumberTriviaModel(
      text: 'test text', number: 1, found: true, type: 'trivia');

  group('getNumberTrivia', () {
    test('should return NumberTriviaModel when call getNumberTrivia', () async {
      when(sharedPreferences.getString(any)).thenReturn(testJson);
      final result = await localSource.getNumberTrivia();
      expect(result, testModel);
      verify(sharedPreferences.getString(cashedNumberTrivia));
    });

    test('should throw CashException when call getNumberTrivia', () async {
      when(sharedPreferences.getString(any)).thenReturn(null);
      final result = localSource.getNumberTrivia;
      expect(() => result(), throwsA(const TypeMatcher<CashException>()));
    });
  });

  group('setNumberTrivia', () {
    test('should call setString with proper data when call the setNumberTrivia ', () async {
      when(sharedPreferences.setString(any, any))
          .thenAnswer((realInvocation) async => true);
      localSource.setNumberTrivia(testModel);
      final expectedJsonString = json.encode(testModel.toJson());
      verify(
          sharedPreferences.setString(cashedNumberTrivia, expectedJsonString));
    });
  });
}
