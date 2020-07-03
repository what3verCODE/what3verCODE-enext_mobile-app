class Answer {
  int id;
  String value;
  bool isCorrect;

  Answer({this.id, this.value, this.isCorrect});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      value: json['value'],
      isCorrect: json['isCorrect']
    );
  }
}