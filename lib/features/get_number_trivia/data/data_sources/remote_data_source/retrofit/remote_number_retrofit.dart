import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/number_trivia_model.dart';
import 'end_points.dart';

part 'remote_number_retrofit.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RemoteNumberRetrofit {
  factory RemoteNumberRetrofit(Dio dio, {String baseUrl}) =
      _RemoteNumberRetrofit;

  @GET(randomNumberTriviaPath)
  Future<NumberTriviaModel> getRandomTrivia();

  @GET(concreteNumberTriviaPath)
  Future<NumberTriviaModel> getConcreteTrivia(@Path('number') int number);
}
