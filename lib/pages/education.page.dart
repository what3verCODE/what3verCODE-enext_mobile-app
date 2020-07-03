import 'package:enext/enums/questiontypes.enum.dart';
import 'package:enext/enums/sectiontypes.enum.dart';
import 'package:enext/models/quiz.model.dart';
import 'package:enext/models/section.model.dart';
import 'package:enext/models/question.model.dart';
import 'package:enext/models/answer.model.dart';
import 'package:flutter/material.dart';
import '../models/course.model.dart';
import '../models/lesson.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EducationPage extends StatefulWidget {
  static const routeName = '/education';

  //final int courseId = 0;

  //EducationPage({Key key, this.courseId}) : super(key: key);

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  Future<Course> _course;
  List<int> _lessonsMap;
  int _currentLesson;
  Future<Lesson> _lesson;

  bool debug;

  Future<Course> debugCourse() async {
    Map<String, dynamic> json = {
      "id": 1,
      "title": "Docker + React + Jelastic = LOVE",
      "description": "Course Description",
      "modules": [
        {
          "id": 1,
          "title": "Docker",
          "lessons": [
            {
              "id": 1,
              "title": "Dockerfile",
            },
            {
              "id": 2,
              "title": "Docker Build",
            },
            {
              "id": 3,
              "title": "Docker Push",
            },
          ]
        },
        {
          "id": 1,
          "title": "React",
          "lessons": [
            {
              "id": 1,
              "title": "React Actions",
            },
            {
              "id": 2,
              "title": "React Reducers",
            },
            {
              "id": 3,
              "title": "React Sagas",
            },
          ]
        },
        {
          "id": 1,
          "title": "Jelastic",
          "lessons": [
            {
              "id": 1,
              "title": "Container",
            },
            {
              "id": 2,
              "title": "Firewall",
            },
            {
              "id": 3,
              "title": "Push container",
            },
          ]
        },
      ]
    };

    return Course.fromJson(json, true);
  }
  Future<Lesson> debugLesson() async {
    Map<String, dynamic> json = {
      "id": 0,
      "title": "Lesson Title",
      "sections": [
        {
          "id": 1,
          "type": 0,
          "text": "Text",
          "videoUrl": null,
          "quiz": null,
        },
        {
          "id": 3,
          "type": 2,
          "text": null,
          "videoUrl": null,
          "quiz": {
            "id": 1,
            "questions": [
              {
                "id": 1,
                "value": "Тестовый вопрос...?",
                "type": 0,
                "answers": [
                  {
                    "id": 1,
                    "value": "Вариант ответа А",
                    "isCorrect": false
                  },
                  {
                    "id": 2,
                    "value": "Вариант ответа Б",
                    "isCorrect": false
                  },
                  {
                    "id": 3,
                    "value": "Вариант ответа В",
                    "isCorrect": false
                  },
                ]
              },
              {
                "id": 2,
                "value": "Тестовый вопрос...?",
                "type": 1,
                "answers": [
                  {
                    "id": 4,
                    "value": "Вариант ответа А",
                    "isCorrect": false
                  },
                  {
                    "id": 5,
                    "value": "Вариант ответа Б",
                    "isCorrect": false
                  },
                  {
                    "id": 6,
                    "value": "Вариант ответа В",
                    "isCorrect": false
                  },
                ]
              }
            ]
          }
        }
      ]
    };

    return Lesson.fromJson(json);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      debug = true;
    });

    if(debug) {
      setState(() {
        _course = debugCourse();
        _lesson = debugLesson();
      });
    } else {
      setState(() {
        _course = fetchCourse();
        _course
            .then((value) => {
          _lessonsMap = value.getLessonsMap()
        });
        getLastVisited()
            .then((value) => {
          _currentLesson = value
        });
        _lesson = fetchLesson(_currentLesson);
      });
    }
  }

  Future<Course> fetchCourse() async {
    var url = '';
    var response = await http.get(url);

    if(response.statusCode == 200) {
      var courseJson = json.decode(response.body);
      var course = Course.fromJson(courseJson, true);
      return course;
    } else {
      throw Exception('Failed to load course from API');
    }
  }
  Future<int> getLastVisited() async {
    //var url = '/${widget.courseId}';
    var url = '';
    var response = await http.get(url);
  }
  Future<Lesson> fetchLesson(int id) async {
    var url = '';
    var response = await http.get(url);

    if(response.statusCode == 200) {
      var lessonJson = json.decode(response.body);
      var lesson = Lesson.fromJson(lessonJson);
      return lesson;
    } else {
      throw Exception('Failed to load course from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    final EducationArguments args = ModalRoute.of(context).settings.arguments;

    Container textSection(String text) => Container(
      //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: Text(text),
    );

    Container videoSection(String url) => Container(
      //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: Column(
        children: <Widget>[
        ],
      )
    );

    Container singleChoiceAnswer(Answer answer) => Container(
      child: Row(
        children: <Widget>[
          Radio(
            value: false,
            groupValue: answer.id.toString(),
            onChanged: (s) { },
          ),
          Text(answer.value)
        ],
      ),
    );

    Container multipleChoiceAnswer(Answer answer) => Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: false,
            onChanged: (s) { },
          ),
          Text(answer.value)
        ],
      ),
    );

    Container answer(QuestionTypes type, Answer answer) {
      if(type == QuestionTypes.SingleChoice)
        return singleChoiceAnswer(answer);
      return multipleChoiceAnswer(answer);
    }

    Container question(Question question) => Container(
      child: Column(
        children: <Widget>[
          Text(question.value),
          SizedBox(height: 5.0,),
          ListView.builder(
              itemCount: question.answers.length,
              itemBuilder: (context, index) => answer(question.type, question.answers[index])),
        ],
      )
    );

    Container quizSection(Quiz quiz) => Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: ListView.builder(
          itemCount: quiz.questions.length,
          itemBuilder: (context, index) =>  question(quiz.questions[index])
      ),
    );

    Widget lessonSection(Section section) {
        Widget _widget;
        print(section);
        if(section.type == LessonSectionTypes.Text) {
          _widget = textSection(section.text);
        } else if(section.type == LessonSectionTypes.Video) {
          _widget = videoSection(section.videoUrl);
        } else if(section.type == LessonSectionTypes.Quiz) {
          _widget = quizSection(section.quiz);
        }

        return Card(
          elevation: 8.0,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: _widget,
          )
        );
    }

    Container lessonContent(Lesson lesson) => Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: lesson.sections.length,
          itemBuilder: (context, index) {
            return lessonSection(lesson.sections[index]);
          }
      ),
    );

    Container page(Course course) => Container(
      child: FutureBuilder<Lesson>(
        future: debugLesson(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return lessonContent(snapshot.data);
          } else if(snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );

    Container courseNavigation() => Container(
      child: Text(""),
    );

    if(debug) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ASD"),
          actions: <Widget>[

          ],),
        body: FutureBuilder<Course>(
          future: debugCourse(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return page(snapshot.data);
            } else if(snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("ASD"),
          actions: <Widget>[

          ],),
        body: FutureBuilder<Course>(
          future: _course,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  children: <Widget>[
                    page(snapshot.data)
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

class EducationArguments {
  final int courseId;

  EducationArguments({this.courseId});
}