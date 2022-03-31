import 'package:dartz/dartz.dart';
import 'package:number_trivia_app_tdd/core/errors/failures.dart';
import 'package:number_trivia_app_tdd/core/use_case/use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/repositories/number_trivia_repositoriy.dart';

class RandomNumberTriviaUseCase
    implements UseCase<NumberTriviaEntity, NoParams> {
  final NumberTriviaDomainRepository repository;

  RandomNumberTriviaUseCase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NoParams params) {
    return repository.getRandomNumberTrivia();
  }
}
