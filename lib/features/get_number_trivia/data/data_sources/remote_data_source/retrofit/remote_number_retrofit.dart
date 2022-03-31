import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart' as http;

import '../../../models/number_trivia_model.dart';
import 'end_points.dart';

part 'remote_number_retrofit.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RemoteNumberRetrofit {
  factory RemoteNumberRetrofit(Dio dio, {String baseUrl}) =
      _RemoteNumberRetrofit;

  @GET(randomNumberTriviaPath)
  @http.Headers({
    'Content-Type': 'application/json',
  })
  Future<NumberTriviaModel> getRandomTrivia();

  @GET(concreteNumberTriviaPath)
  @http.Headers({
    'Content-Type': 'application/json',
  })
  Future<NumberTriviaModel> getConcreteTrivia(@Path('number') int number);
}