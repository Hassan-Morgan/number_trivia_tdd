import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app_tdd/core/errors/failures.dart';
import 'package:number_trivia_app_tdd/core/presentation/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group('inputConverter', () {
    test(
        'should return int value when call inputConverter with string input contains integer',
        () {
      String testInput = '123';
      final result = inputConverter.inputConverter(testInput);
      expect(result, const Right(123));
    });
    test('should return InputFailure when the input string contains String',
        () {
      String testInput = 'abc';
      final result = inputConverter.inputConverter(testInput);
      expect(result, Left(InputFailure('the input cannot be text')));
    });
    test('should return InputFailure when the input string contains double',
        () {
      String testInput = '1.0';
      final result = inputConverter.inputConverter(testInput);
      expect(result, Left(InputFailure('the input cannot be double')));
    });

    test('should return InputFailure when the input string contains double',
        () {
      String testInput = '-123';
      final result = inputConverter.inputConverter(testInput);
      expect(result, Left(InputFailure('the input cannot be negative number')));
    });
  });
}
