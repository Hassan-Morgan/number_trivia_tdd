import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/mappers/number_trivia_mapper.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const NumberTriviaModel testModel = NumberTriviaModel(
      text: 'test text', number: 1, found: true, type: 'trivia');

  test('the Extension toEntity should return number trivia entity', () {
    final testResult = testModel.toEntity(testModel);
    expect(testResult, isA<NumberTriviaEntity>());
  });

  group('test the model fromJson', () {
    test(
        'model fromJson function should return NumberTriviaModel when Json number is integer ',
        () {
      final jsonResult = json.decode(fixtureReader('number_trivia_json.json'));
      final result = NumberTriviaModel.fromJson(jsonResult);
      expect(result, testModel);
    });
    test(
        'model fromJson function should return NumberTriviaModel when Json number is double ',
        () {
      final jsonResult =
          json.decode(fixtureReader('number_trivia_double_json.json'));
      final result = NumberTriviaModel.fromJson(jsonResult);
      expect(result, testModel);
    });
    test(
        'the toJson function should return a json Map with the right data',
            () {
          final result = testModel.toJson();
          final expectedMap = {
            "text": "test text",
            "number": 1,
            "found": true,
            "type": "trivia"
          };
          expect(expectedMap, result);
        });
  });
}
