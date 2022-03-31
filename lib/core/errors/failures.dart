import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CashFailure extends Failure {}


class InputFailure extends Equatable {
  final String failureMessage;

  const InputFailure(this.failureMessage);

  @override
  List<Object?> get props => [failureMessage];
}
