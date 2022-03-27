import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends Equatable {
  const NumberTriviaModel({
    required this.text,
    required this.number,
    required this.found,
    required this.type,
  });

  final String text;
  final int number;
  final bool found;
  final String type;

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);

  @override
  List<Object?> get props => [text, number];
}
