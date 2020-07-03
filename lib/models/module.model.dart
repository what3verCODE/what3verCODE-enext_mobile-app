import './lesson.model.dart';

class Module {
  final int id;
  final List<Lesson> lessons;

  Module({this.id, this.lessons});

  factory Module.fromJson(Map<String, dynamic> json) {
    var lessonsJson = json['lessons'];
    List<Lesson> lessonsList = lessonsJson.cast<Lesson>();
    return Module(
      id: json['id'],
      lessons: lessonsList
    );
  }
}