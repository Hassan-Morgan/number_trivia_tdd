import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app_tdd/core/presentation/utils/input_converter.dart';
import 'package:number_trivia_app_tdd/core/use_case/use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/concret_number_trivia_use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/randome_number_trivia_use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/logic/number_trivia_states/number_trivia_states.dart';

import '../../../../core/errors/failures.dart';

class NumberTriviaCubit extends Cubit<NumberTriviaStates> {
  final InputConverter inputConverter;
  final ConcreteNumberTriviaUseCase concreteNumberTriviaUseCase;
  final RandomNumberTriviaUseCase randomNumberTriviaUseCase;

  NumberTriviaCubit({
    required this.inputConverter,
    required this.concreteNumberTriviaUseCase,
    required this.randomNumberTriviaUseCase,
  }) : super(NumberTriviaStates.initial());

  Future<void> getConcreteNumberTrivia(String number) async {
    inputConverter.inputConverter(number).fold(
      (failure) {
        emit(NumberTriviaStates.error(failure.failureMessage));
      },
      (int number) async {
        emit(NumberTriviaStates.loading());
        Either<Failure, NumberTriviaEntity> result =
            await concreteNumberTriviaUseCase(ConcreteNumberParams(number));
        result.fold((Failure failure) {
          final String message = failureHandler(failure);
          emit(NumberTriviaStates.error(message));
        }, (NumberTriviaEntity entity) {
          emit(NumberTriviaStates.success(entity));
        });
      },
    );
  }

  Future<void> getRandomNumberTrivia() async {
    emit(NumberTriviaStates.loading());
    Either<Failure, NumberTriviaEntity> result =
        await randomNumberTriviaUseCase(NoParams());
    result.fold((Failure failure) {
      final String error = failureHandler(failure);
      emit(NumberTriviaStates.error(error));
    }, (NumberTriviaEntity entity) {
      emit(NumberTriviaStates.success(entity));
    });
  }

  String failureHandler(Failure failure) {
    switch (failure.runtimeType) {
      case CashFailure:
        return cashFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
      default:
        return unhandledFailureMessage;
    }
  }
}

const cashFailureMessage =
    'cash Failure, it seems no local data stored in your device, please connect to internet and try again later';
const serverFailureMessage =
    'server failure, this error happened from the server';
const unhandledFailureMessage =
    'unhandled error happened please try again later';
