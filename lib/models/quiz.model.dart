import 'question.model.dart';

class Quiz {
  int id;
  List<Question> questions;

  Quiz({this.id, this.questions});

  factory Quiz.fromJson(Map<String, dynamic> map) {
    var list = map['questions'] as List;
    List<Question> questionsList = list.map((e) => Question.fromJson(e)).toList();

    return Quiz(
      id: map['id'],
      questions: questionsList
    );
  }
}