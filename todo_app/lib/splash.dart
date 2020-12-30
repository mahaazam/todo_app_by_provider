import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_provider.dart';
import 'package:todo_app/db_helper.dart';

import 'main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<AppProvider>(
      builder: (context, value, child) {
        var tasks =
            value.getTasksFromDB(DBHelper.dbHelper.selectAllTasks, myFun);
        value.setValue(tasks);
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TabBarPage()),
          );
        });
        return Container();
      },
    ));
  }

  void myFun() {
    setState(() {});
  }
}
