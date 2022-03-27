import 'dart:convert';

import 'package:number_trivia_app_tdd/core/errors/execptions.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cashedNumberTrivia = 'cashed_number';

abstract class LocalNumberTriviaDataSource {
  Future<NumberTriviaModel> getNumberTrivia();

  Future<void> setNumberTrivia(NumberTriviaModel numberTrivia);
}

class LocalNumberTriviaDataSourceImpl implements LocalNumberTriviaDataSource {
  SharedPreferences sharedPreferences;

  LocalNumberTriviaDataSourceImpl(this.sharedPreferences);

  @override
  Future<NumberTriviaModel> getNumberTrivia() async {
    String? stringJson = sharedPreferences.getString(cashedNumberTrivia);
    if (stringJson != null) {
      Map<String, dynamic> jsonData = json.decode(stringJson);
      NumberTriviaModel numberModel = NumberTriviaModel.fromJson(jsonData);
      return numberModel;
    } else {
      throw CashException();
    }
  }

  @override
  Future<void> setNumberTrivia(NumberTriviaModel numberTrivia) async {
    Map<String, dynamic> numberTriviaMap = numberTrivia.toJson();
    String numberTriviaJson = json.encode(numberTriviaMap);
    await sharedPreferences.setString(cashedNumberTrivia, numberTriviaJson);
  }
}
