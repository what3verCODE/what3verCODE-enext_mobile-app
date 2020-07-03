import 'package:enext/enums/questiontypes.enum.dart';
import 'answer.model.dart';

class Question {
  int id;
  QuestionTypes type;
  String value;
  List<Answer> answers;

  Question({
    this.id,
    this.value,
    this.type,
    this.answers
  });

  factory Question.fromJson(Map<String, dynamic> map) {
    var list = map['answers'] as List;
    List<Answer> answersList = list.map((e) => Answer.fromJson(e)).toList();

    int intType = map['type'];
    QuestionTypes type = QuestionTypes.values[intType];

    print(map['value']);

    return Question(
      id: map['id'],
      value: map['value'],
      type: type,
      answers: answersList
    );
  }
}