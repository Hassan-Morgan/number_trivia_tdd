import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app_tdd/core/use_case/use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/repositories/number_trivia_repositoriy.dart';

import '../../../../core/errors/failures.dart';

class ConcreteNumberTriviaUseCase
    implements UseCase<NumberTriviaEntity, ConcreteNumberParams> {
  final NumberTriviaDomainRepository repository;

  ConcreteNumberTriviaUseCase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(
      ConcreteNumberParams params) {
    return repository.getConcreteNumberTrivia(params.number);
  }
}

class ConcreteNumberParams extends Equatable {
  final int number;

  const ConcreteNumberParams(this.number);

  @override
  List<Object?> get props => [number];
}
