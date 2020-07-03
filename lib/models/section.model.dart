import 'package:enext/enums/sectiontypes.enum.dart';
import 'package:enext/models/quiz.model.dart';
import 'package:json_annotation/json_annotation.dart';

class Section {
  int id;
  LessonSectionTypes type;
  String text;
  String videoUrl;
  Quiz quiz;

  Section({
    this.id,
    this.type,
    this.text,
    this.videoUrl,
    this.quiz
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    int intType = json['type'];
    LessonSectionTypes type = LessonSectionTypes.values[intType];

    if(type == LessonSectionTypes.Text) {
      return Section(
        id: json['id'],
        type: type,
        text: json['text']
      );
    } else if(type == LessonSectionTypes.Video) {
      return Section(
        id: json['id'],
        type: type,
        videoUrl: json['videoUrl']
      );
    } else {
      Quiz quiz = Quiz.fromJson(json['quiz']);
      return Section(
          id: json['id'],
          type: type,
          quiz: quiz
      );
    }
  }
}