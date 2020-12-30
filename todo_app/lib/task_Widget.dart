import 'package:provider/provider.dart';
import 'package:todo_app/app_provider.dart';
import 'package:todo_app/task_model.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  Function fun1;
  Function fun2;
  TaskWidget(this.task, [this.fun2, this.fun1]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    //Card()
    return Container(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert"),
                          content:
                              Text(" You Will Delete A task, are you sure?"),
                          actions: <Widget>[
                            FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .deleteTask(widget.task);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }),
                            FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                }),
            Text(
              widget.task.taskName,
              style: TextStyle(fontSize: 16),
            ),
            Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  this.widget.task.isComplete = !this.widget.task.isComplete;
                  Provider.of<AppProvider>(context, listen: false)
                      .updateTask(widget.task);
                  setState(() {});
                  widget.fun1();
                })
          ],
        ),
      ),
    );
  }
}
