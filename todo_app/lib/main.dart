import 'package:provider/provider.dart';
import 'package:todo_app/task_Widget.dart';
import 'package:todo_app/task_model.dart';
import 'package:flutter/material.dart';
import 'app_provider.dart';
import 'newTasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AppProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabBarPage(),
      ),
    );
  }
}

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Task> tasks;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Todo'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'In Complete Tasks',
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [AllTasks(), CompleteTasks(), IncompleteTasks()],
              // physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NewTasks();
            },
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  void fun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: context.watch<AppProvider>().getValue().length,
        itemBuilder: (context, index) {
          Task task = context.watch<AppProvider>().getValue()[index];
          return TaskWidget(task, fun);
        },
      ),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompletedTasksState createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompleteTasks> {
  void fun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: context.watch<AppProvider>().getValue().length,
        itemBuilder: (context, index) {
          Task task = context.watch<AppProvider>().getValue()[index];
          if (task.isComplete) {
            return TaskWidget(task, fun);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class IncompleteTasks extends StatefulWidget {
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
  void fun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: context.watch<AppProvider>().getValue().length,
      itemBuilder: (context, index) {
        Task task = context.watch<AppProvider>().getValue()[index];
        if (!task.isComplete) {
          return TaskWidget(task, fun);
        } else {
          return Container();
        }
      },
    ));
  }
}
