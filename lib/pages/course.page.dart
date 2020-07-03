import 'package:flutter/material.dart';
import 'package:enext/models/course.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursePage extends StatefulWidget {
  final int courseId;

  const CoursePage({Key key, this.courseId}) : super(key: key);


  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Future<Course> _course;

  @override
  void initState() {
    super.initState();

    _course = fetchCourse();
  }

  Future<void> reloadData() async {
    setState(() {
      _course = fetchCourse();
    });
  }
  Future<Course> fetchCourse() async {
    var url = 'http://194.58.114.121/courses/${widget.courseId}';
    var response = await http.get(url);

    if(response.statusCode == 200) {
      return Course.fromJson(json.decode(response.body), true);
    } else {
      throw Exception('Failed to load courses from API');
    }
  }
  void subscribe() async {
    var url = 'http://194.58.114.121/subscriptions/${widget.courseId}';
    Map<String, int> body = {
      "courseId": widget.courseId
    };
    var response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer '
        }
    );
    if(response.statusCode == 200) {
      setState(() {
        _course.then((value) => value.subscribed = true);
      });
    }
  }
  void unsubscribe() async {
    var url = 'http://194.58.114.121/subscriptions/${widget.courseId}';
    Map<String, int> body = {
      "courseId": widget.courseId
    };
    var response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer '
      }
    );

    if(response.statusCode == 200) {
      setState(() {
        _course.then((value) => value.subscribed = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Column topContentText(Course course) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(Icons.school, color: Colors.white, size: 40.0),
        SizedBox(height: 10.0),
        Text(course.title, style: TextStyle(color: Colors.white, fontSize: 24.0)),
        SizedBox(height: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.description, color: Colors.white, size: 16.0),
                SizedBox(width: 6.0),
                Flexible(
                  child: Text(
                      course.shortDescription,
                      style: TextStyle(color: Colors.white, fontSize: 14.0)
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.timer, color: Colors.white, size: 16.0),
                SizedBox(width: 6.0),
                Flexible(
                  child: Text(
                      course.charge,
                      style: TextStyle(color: Colors.white, fontSize: 14.0)
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
    Stack topContent(Course course) => Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
//            image: DecorationImage(
//              image: AssetImage(""),
//              fit: BoxFit.cover
//            )
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
              child: Flexible(
                child: topContentText(course),
              )
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            child: Icon(Icons.arrow_back, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );

    Container getButton(bool isSubscribed) {
      if(isSubscribed) {
        return new Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: RaisedButton(
                  child: Text("Отписаться", style: TextStyle(color: Colors.white70)),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  onPressed: () {

                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: RaisedButton(
                  child: Text("Перейти к изучению", style: TextStyle(color: Colors.white70)),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  onPressed: () {

                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      } else {
        return new Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    child: Text("Подписаться", style: TextStyle(color: Colors.white70)),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    onPressed: () {

                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            )
        );
      }
    }

    Container description(String description) => Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("О курсе", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
          SizedBox(height: 5.0,),
          Text(description)
        ],
      ),
    );

    Container audience(String targetAudience) => Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Для кого этот курс", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
          SizedBox(height: 5.0,),
          Text(targetAudience)
        ],
      ),
    );

    Container authors() => Container(
      child: Text(""),
    );

    Container courseProgram() => Container(
      child: Text(""),
    );

    Container bottomContent(Course course) => Container(
      child: Column(
        children: <Widget>[
          getButton(true),
          description(course.description),
          SizedBox(height: 20.0,),
          audience(course.targetAudience),
          SizedBox(height: 20.0,),
          authors(),
          SizedBox(height: 20.0,),
          courseProgram(),
        ],
      ),
    );

    return Scaffold(
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
                    topContent(snapshot.data),
                    bottomContent(snapshot.data)
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
