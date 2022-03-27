import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_tdd/core/use_case/use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/repositories/number_trivia_repositoriy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/randome_number_trivia_use_case.dart';

import '../concrete_number_trivia_use_case_test/number_trivia_use_case_test.mocks.dart';

@GenerateMocks([NumberTriviaDomainRepository])
void main() {
  late MockNumberTriviaDomainRepository repository;
  late RandomNumberTriviaUseCase useCase;

  setUp(() {
    repository = MockNumberTriviaDomainRepository();
    useCase = RandomNumberTriviaUseCase(repository);
  });
  const answer = NumberTriviaEntity(text: 'test text', number: 1);

  test(
      'should get the trivia of random number from repository and return it as NumberTriviaEntity',
      () async {
    when(repository.getRandomNumberTrivia())
        .thenAnswer((realInvocation) async => const Right(answer));
    final result = await useCase(NoParams());
    expect(result, const Right(answer));
    verify(repository.getRandomNumberTrivia());
    verifyNoMoreInteractions(MockNumberTriviaDomainRepository());
  });
}