import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../errors/failures.dart';

@lazySingleton
class InputConverter {
  Either<InputFailure, int> inputConverter(String input) {
    try {
      int result = int.parse(input);
      if (result < 0) {
        return const Left(InputFailure('the input cannot be negative number'));
      }
      return Right(result);
    } on FormatException {
      try {
        double.parse(input);
        return const Left(InputFailure('the input cannot be double'));
      } on FormatException {
        return const Left(InputFailure('the input cannot be text'));
      }
    }
  }
}
