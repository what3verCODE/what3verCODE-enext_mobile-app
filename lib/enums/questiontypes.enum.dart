import 'package:json_annotation/json_annotation.dart';

enum QuestionTypes {
  @JsonValue(0) SingleChoice,
  @JsonValue(1) MultipleChoice
}