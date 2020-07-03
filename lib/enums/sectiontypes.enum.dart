import 'package:json_annotation/json_annotation.dart';

enum LessonSectionTypes {
  @JsonValue(0) Text,
  @JsonValue(1) Video,
  @JsonValue(2) Quiz
}