import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_tdd/core/errors/failures.dart';
import 'package:number_trivia_app_tdd/core/presentation/utils/input_converter.dart';
import 'package:number_trivia_app_tdd/core/use_case/use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/concret_number_trivia_use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/randome_number_trivia_use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/logic/number_trivia_cubit.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/logic/number_trivia_states/number_trivia_states.dart';

import 'number_trivia_cubit_test.mocks.dart';

@GenerateMocks(
    [InputConverter, ConcreteNumberTriviaUseCase, RandomNumberTriviaUseCase])
void main() {
  late NumberTriviaCubit numberTriviaCubit;
  late MockInputConverter inputConverter;
  late MockConcreteNumberTriviaUseCase concreteNumberTriviaUseCase;
  late MockRandomNumberTriviaUseCase randomNumberTriviaUseCase;
  setUp(
    () {
      inputConverter = MockInputConverter();
      concreteNumberTriviaUseCase = MockConcreteNumberTriviaUseCase();
      randomNumberTriviaUseCase = MockRandomNumberTriviaUseCase();
      numberTriviaCubit = NumberTriviaCubit(
        inputConverter: inputConverter,
        concreteNumberTriviaUseCase: concreteNumberTriviaUseCase,
        randomNumberTriviaUseCase: randomNumberTriviaUseCase,
      );
    },
  );
  const String testInput = '1';
  const String wrongTestInput = 'abc';
  const int testNumber = 1;
  const testEntity = NumberTriviaEntity(text: 'test model', number: testNumber);
  test(
      'should ensure that the initial state of the cubit is NumberTriviaStates.initial state',
      () {
    expect(numberTriviaCubit.state, NumberTriviaStates.initial());
  });

  group('getConcreteNumberTrivia', () {
    test(
        'should return InputFailure when the input is wrong and emmit state to error state',
        () {
      when(inputConverter.inputConverter(any))
          .thenReturn(const Left(InputFailure('test text')));
      numberTriviaCubit.getConcreteNumberTrivia(wrongTestInput);
      verify(inputConverter.inputConverter(wrongTestInput));
      expect(numberTriviaCubit.state, NumberTriviaStates.error('test text'));
    });
    group('convert input return int', () {
      setUp(() {
        when(inputConverter.inputConverter(any))
            .thenReturn(const Right(testNumber));
      });
      test(
          '''should return NumberTriviaEntity when call concreteNumberTriviaUseCase and no errors happen
      and should set the state first to loading and when done to success''',
          () async {
        when(concreteNumberTriviaUseCase(any))
            .thenAnswer((realInvocation) async => const Right(testEntity));
        numberTriviaCubit.getConcreteNumberTrivia(testInput);
        expect(numberTriviaCubit.state, NumberTriviaStates.loading());
        await untilCalled(concreteNumberTriviaUseCase(any));
        verify(concreteNumberTriviaUseCase(
            const ConcreteNumberParams(testNumber)));
        expect(numberTriviaCubit.state, NumberTriviaStates.success(testEntity));
      });

      test(
          '''should return Failure when call concreteNumberTriviaUseCase and errors happen
          and should set the state first to loading and when done to error ''',
          () async {
        when(concreteNumberTriviaUseCase(any))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        numberTriviaCubit.getConcreteNumberTrivia(testInput);
        expect(numberTriviaCubit.state, NumberTriviaStates.loading());
        await untilCalled(concreteNumberTriviaUseCase(any));
        verify(concreteNumberTriviaUseCase(
            const ConcreteNumberParams(testNumber)));
        expect(numberTriviaCubit.state, NumberTriviaStates.error(serverFailureMessage));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    test(
        '''should return NumberTriviaEntity when call getRandomNumberTrivia with no errors 
        and set the state first to LoadingState and then to successState''',
        () async {
      when(randomNumberTriviaUseCase(any))
          .thenAnswer((realInvocation) async => const Right(testEntity));
      numberTriviaCubit.getRandomNumberTrivia();
      expect(numberTriviaCubit.state, NumberTriviaStates.loading());
      await untilCalled(randomNumberTriviaUseCase(any));
      verify(randomNumberTriviaUseCase(NoParams()));
      expect(numberTriviaCubit.state, NumberTriviaStates.success(testEntity));
    });
    test(
        '''should return ServerFailure when call getRandomNumberTrivia with errors 
        and set the state first to LoadingState and then to error''', () async {
      when(randomNumberTriviaUseCase(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));
      numberTriviaCubit.getRandomNumberTrivia();
      expect(numberTriviaCubit.state, NumberTriviaStates.loading());
      await untilCalled(randomNumberTriviaUseCase(any));
      verify(randomNumberTriviaUseCase(NoParams()));
      expect(numberTriviaCubit.state, NumberTriviaStates.error(serverFailureMessage));
    });
  });
}
