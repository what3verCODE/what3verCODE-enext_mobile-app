import './module.model.dart';

class Course{
  int id;
  String title;
  String description;
  String shortDescription;
  String targetAudience;
  String charge;
  String avatar;
  int likes;
  bool subscribed;
  List<Module> modules;

  Course({
    this.id,
    this.title,
    this.description,
    this.shortDescription,
    this.targetAudience,
    this.charge,
    this.avatar,
    this.likes,
    this.subscribed,
    this.modules,
  });

  factory Course.fromJson(Map<String, dynamic> json, bool isSingle) {
    if(isSingle) {
      var modulesJson = json['modules'];
      List<Module> modulesList = modulesJson.cast<Module>();
      return Course(
        id: json['id'], 
        title: json['title'],
        description: json['description'],
        shortDescription: json['shortDescription'],
        targetAudience: json['targetAudience'],
        charge: json['charge'],
        avatar: json['avatar'],
        likes: json['likes'],
        subscribed: false,
        modules: modulesList
      );
    }

    return Course(
      id: json['id'],
      title: json['title'],
      shortDescription: json['shortDescription'],
      likes: json['likes'],
    );
  }

  List<int> getLessonsMap() {
    List<int> map = List<int>();

    modules.map((module) => module.lessons.map((lesson) => map.add(lesson.id)));

    return map;
  }
}