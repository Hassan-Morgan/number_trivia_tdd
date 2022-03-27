import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';

extension NumberTriviaMapper on NumberTriviaModel {
  NumberTriviaEntity toEntity(NumberTriviaModel model) {
    return NumberTriviaEntity(text: model.text, number: model.number);
  }
}
