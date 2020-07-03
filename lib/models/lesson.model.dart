import 'package:enext/models/section.model.dart';
import 'dart:convert' as Convert;

class Lesson {
  final int id;
  final String title;
  List<Section> sections;

  Lesson({this.id, this.title, this.sections});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    var list = json['sections'] as List;
    List<Section> sectionsList = list.map((e) => Section.fromJson(e)).toList();

    return Lesson(
      id: json['id'],
      title: json['title'],
      sections: sectionsList
    );
  }
}