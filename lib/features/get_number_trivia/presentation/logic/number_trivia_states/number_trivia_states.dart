import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';

part 'number_trivia_states.freezed.dart';
@Freezed()
abstract class NumberTriviaStates with _$NumberTriviaStates {
    factory NumberTriviaStates.initial() = _initial;

    factory NumberTriviaStates.loading() = _loading;

   factory NumberTriviaStates.error(String error) = _error;

   factory NumberTriviaStates.success(NumberTriviaEntity numberTrivia) =
      _success;
}
