import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Providerr with ChangeNotifier {
  int currnIndex = 0;
  late Providerr providerr;
  void index(int value) {
    currnIndex = value;
    notifyListeners();
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> arcuiveTasks = [];



  
  void createDatabase() async {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)',
            )
            .then((value) {})
            .catchError((error) {
          print(
            'Error When Creating Table ${error.toString()}',
          );
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
      },
    ).then((value) {
      database = value;
    });
    notifyListeners();
  }

  insrtDatabase({
    required String date,
    required String title,
    required String time,
    required BuildContext context,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title,date,time,status VALUES ("$title","$date","$time","new")',
      )
          .then((value) {
        getDataFromDataBase(database);
        Navigator.pop(context);
      }).catchError((er) {
        print('Error When Inserting New Record${er.toString()}');
      });
      return null;
    });
  }

  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    arcuiveTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          arcuiveTasks.add(element);
        }
      });
      notifyListeners();
    });
  }

  updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDataBase(database);
    });
  }

  deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
    });
  }

  bool isBottom = false;
  IconData iconData = Icons.edit;
  void changeBottom({
    required bool isShow,
    required IconData icon,
  }) {
    isBottom = isShow;
    iconData = icon;
    notifyListeners();
  }
}
