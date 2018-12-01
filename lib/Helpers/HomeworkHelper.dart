import 'dart:async';
import 'dart:convert' show utf8, json;
import '../Datas/User.dart';
import '../Datas/Homework.dart';
import '../Datas/StudentHomework.dart';
import '../Datas/Lesson.dart';
import '../Utils/AccountManager.dart';
import '../Utils/Saver.dart';
import 'RequestHelper.dart';

class HomeworkHelper {
  Future<List<Homework>> getHomeworks() async {
    List<Map<String, dynamic>> evaluationsMap =
        new List<Map<String, dynamic>>();
    List<Homework> homeworks = new List<Homework>();

    evaluationsMap = await getHomeworkList();
    homeworks.clear();
    evaluationsMap.forEach((Map<String, dynamic> e) {
      Homework average = Homework.fromJson(e);
      average.owner = e["user"];
      print(average.subject);
      print(average.text);
      homeworks.add(average);
    });
    homeworks
        .sort((Homework a, Homework b) => a.owner.name.compareTo(b.owner.name));

    return homeworks;
  }

  Future<List<Homework>> getHomeworksOffline() async {
    List<Map<String, dynamic>> evaluationsMap =
        new List<Map<String, dynamic>>();
    List<Homework> homeworks = new List<Homework>();
    List<User> users = await AccountManager().getUsers();
    for (User user in users) {
      Map<String, User> userProperty = <String, User>{"user": user};
      List<Map<String, dynamic>> evaluationsMapUser = await readHomework(user);
      evaluationsMapUser
          .forEach((Map<String, dynamic> e) => e.addAll(userProperty));
      evaluationsMap.addAll(evaluationsMapUser);
    }
    homeworks.clear();
    if (evaluationsMap != null)
      for (int n = 0; n < evaluationsMap.length; n++) {
        Homework homework = new Homework.fromJson(evaluationsMap[n]);
        homework.owner = evaluationsMap[n]["user"];
        homeworks.add(homework);
      }
    homeworks
        .sort((Homework a, Homework b) => a.owner.name.compareTo(b.owner.name));

    return homeworks;
  }

  Future<List<Map<String, dynamic>>> getHomeworkList() async {
    List<Map<String, dynamic>> homeworkMap = new List<Map<String, dynamic>>();
    List<User> users = await AccountManager().getUsers();

    for (User user in users) {
      String instCode = user.schoolCode; //suli kódja
      String userName = user.username;
      String password = user.password;

      String jsonBody = "institute_code=" +
          instCode +
          "&userName=" +
          userName +
          "&password=" +
          password +
          "&grant_type=password&client_id=919e0c1c-76a2-4646-a2fb-7085bbbf3c56";

      Map<String, dynamic> bearerMap = json
          .decode((await RequestHelper().getBearer(jsonBody, instCode)).body);

      String code = bearerMap.values.toList()[0];

      DateTime startDate = new DateTime.now();
      startDate =
          startDate.add(new Duration(days: (-1 * startDate.weekday + 1)));
      DateTime from = startDate.subtract(new Duration(days: 27));
      DateTime to = startDate.add(new Duration(days: 30));

      String timetableString = (await RequestHelper().getTimeTable(
              from.toIso8601String().substring(0, 10),
              to.toIso8601String().substring(0, 10),
              code,
              instCode))
          .body;
      List<dynamic> ttMap = json.decode(timetableString);
      //saveTimetable(timetableString, from.year.toString()+"-"+from.month.toString()+"-"+from.day.toString()+"_"+to.year.toString()+"-"+to.month.toString()+"-"+to.day.toString(), user);
      List<Lesson> lessons = new List();
      List<Map<String, dynamic>> hwmapuser = new List();

      for (dynamic d in ttMap) {
        if (d["TeacherHomeworkId"] != null) {
          print(d);
          print("has homework");

          String homeworkString = (await RequestHelper()
                  .getHomework(code, instCode, d["TeacherHomeworkId"]))
              .body;
          if (homeworkString == "[]")
            homeworkString = "[" +
                (await RequestHelper().getHomeworkByTeacher(
                        code, instCode, d["TeacherHomeworkId"]))
                    .body +
                "]";
          print(homeworkString);

          //saveEvaluations(homeworkString, user);

          List<dynamic> evaluationsMapUser = json.decode(homeworkString);
          for (dynamic d in evaluationsMapUser)
            hwmapuser.add(d as Map<String, dynamic>);

          Map<String, String> lessonProperty = <String, String>{
            "subject": d["Subject"]
          };
          hwmapuser
              .forEach((Map<String, dynamic> e) => e.addAll(lessonProperty));

          print(hwmapuser);
        }
      }

      Map<String, User> userProperty = <String, User>{"user": user};
      print(json.encode(hwmapuser));
      saveHomework(json.encode(hwmapuser), user);
      hwmapuser.forEach((Map<String, dynamic> e) => e.addAll(userProperty));
      homeworkMap.addAll(hwmapuser);
      hwmapuser.clear();
    }
    return homeworkMap;
  }
}
