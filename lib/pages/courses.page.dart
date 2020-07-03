import 'package:enext/models/course.model.dart';
import 'package:enext/pages/course.page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursesPage extends StatefulWidget {
  static const routeName = '/courses';

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {

  Future<List<Course>> fetchCourses() async {
    var url = 'http://194.58.114.121/courses';
    var response = await http.get(url);

    if(response.statusCode == 200) {
      List coursesJson = json.decode(response.body);
      return coursesJson.map((course) => new Course.fromJson(course, false)).toList();;
    } else {
      throw Exception('Failed to load courses from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text('Курсы'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () { },
        )
      ],
    );

    final bottomAppBar = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () { },
            ),
            IconButton(
              icon: Icon(Icons.school, color: Colors.white),
              onPressed: () { },
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () { },
            ),
          ],
        ),
      ),
    );


    Column courseCardRow(Course course) => Column(
      children: <Widget>[
        Container(
          height: 150.0,
          padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://www.arcgis.com/sharing/rest/content/items/6c036c09c490450db100cbf867c7688a/resources/1571940616424.png")
            )
          ),
        ),
        Container(
          height: 200.0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(course.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0)),
                ),
                SizedBox(height: 20.0),
                Flexible(
                  child: Text(course.shortDescription, style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    child: Text("Подробнее...", style: TextStyle(color: Colors.white),),
                    color: Color.fromRGBO(64, 75, 96, .6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {

                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );

    Card courseCard(Course course) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: courseCardRow(course),
      ),
    );

    Container coursesList(List<Course> courses) => Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return courseCard(courses[index]);
        },
      ),
    );

    final pageBody = Container(
      child: FutureBuilder<List<Course>>(
        future: fetchCourses(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return coursesList(snapshot.data);
          } else if(snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );

    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: topAppBar,
        bottomNavigationBar: bottomAppBar,
        body: pageBody
    );
  }
}