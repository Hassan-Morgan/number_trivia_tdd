import 'package:dartz/dartz.dart';
import 'package:number_trivia_app_tdd/core/errors/failures.dart';
import 'package:number_trivia_app_tdd/core/network_info/network_info.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/remote_data_source/remote_number_trivia_data_source.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/mappers/number_trivia_mapper.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/entities/number_trivia_entitiy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/repositories/number_trivia_repositoriy.dart';

import '../../../../core/errors/execptions.dart';
import '../data_sources/local_data_source/local_number_trivia_data_source.dart';

class NumberTriviaDataRepository implements NumberTriviaDomainRepository {
  final NetworkInfo networkInfo;
  final LocalNumberTriviaDataSource localNumberTriviaDataSource;
  final RemoteNumberTriviaDataSource remoteNumberTriviaDataSource;

  NumberTriviaDataRepository({
    required this.remoteNumberTriviaDataSource,
    required this.localNumberTriviaDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
      int? number) async {
    return await _randomOrConcreteNumberTrivia(
        () => remoteNumberTriviaDataSource.getConcreteNumberTrivia(number!));
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia() async {
    return await _randomOrConcreteNumberTrivia(
        () => remoteNumberTriviaDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTriviaEntity>> _randomOrConcreteNumberTrivia(
    Future<NumberTriviaModel> Function() getRandomOrConcreteNumber,
  ) async {
    if (await networkInfo.getCurrentConnectionState) {
      try {
        NumberTriviaModel resultModel = await getRandomOrConcreteNumber();
        NumberTriviaEntity resultEntity = resultModel.toEntity(resultModel);
        await localNumberTriviaDataSource.setNumberTrivia(resultModel);
        return Right(resultEntity);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        NumberTriviaModel resultModel =
            await localNumberTriviaDataSource.getNumberTrivia();
        NumberTriviaEntity resultEntity = resultModel.toEntity(resultModel);
        return Right(resultEntity);
      } on CashException {
        return Left(CashFailure());
      }
    }
  }
}
