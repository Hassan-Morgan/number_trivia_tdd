import 'package:dartz/dartz.dart';
import 'package:number_trivia_app_tdd/core/errors/failures.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';

abstract class NumberTriviaDomainRepository{
  Future<Either<Failure,NumberTriviaEntity>> getConcreteNumberTrivia(int? number);
  Future<Either<Failure,NumberTriviaEntity>> getRandomNumberTrivia();
}