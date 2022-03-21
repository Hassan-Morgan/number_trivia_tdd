import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/repositories/number_trivia_repositoriy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/concret_number_trivia_use_case.dart';

import 'number_trivia_use_case_test.mocks.dart';

@GenerateMocks([NumberTriviaDomainRepository])
void main() {
  late MockNumberTriviaDomainRepository repository;
  late ConcreteNumberTriviaUseCase useCase;
  setUp(() {
    repository = MockNumberTriviaDomainRepository();
    useCase = ConcreteNumberTriviaUseCase(repository);
  });

  ConcreteNumberParams params = const ConcreteNumberParams(1);
  final answer = NumberTriviaEntity(text: 'test text', number: params.number);

  test(
      'should get the trivia of the number from repository and return it as NumberTriviaEntity',
      () async {
    when(repository.getConcreteNumberTrivia(any))
        .thenAnswer((realInvocation) async =>  Right(answer));
    final result = await useCase(params);
    expect(result,  Right(answer));
    verify(repository.getConcreteNumberTrivia(params.number));
    verifyNoMoreInteractions(MockNumberTriviaDomainRepository());
  });
}
