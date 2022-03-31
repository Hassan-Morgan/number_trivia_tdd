import 'package:number_trivia_app_tdd/core/errors/execptions.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/remote_data_source/retrofit/remote_number_retrofit.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';


abstract class RemoteNumberTriviaDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class RemoteNumberTriviaDataSourceImpl implements RemoteNumberTriviaDataSource {
  RemoteNumberRetrofit numberRetrofit;

  RemoteNumberTriviaDataSourceImpl({required this.numberRetrofit});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    try {
      NumberTriviaModel numberTriviaModel =
          await numberRetrofit.getConcreteTrivia(number);
      return numberTriviaModel;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    try {
      NumberTriviaModel numberTriviaModel =
          await numberRetrofit.getRandomTrivia();
      return numberTriviaModel;
    } catch (e) {
      throw ServerException();
    }
  }
}
