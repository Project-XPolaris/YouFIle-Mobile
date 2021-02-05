import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfile/api/task.dart';
import 'package:youfile/components/CopyTaskCard.dart';
import 'package:youfile/components/DeleteTaskCard.dart';
import 'package:youfile/ui/home/provider.dart';
import 'package:youfile/ui/task/provider.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<TaskProvider>(
        create: (_) => TaskProvider(),
        child: Consumer<TaskProvider>(builder: (context, provider, child) {
          List<Widget> getTaskList(){
            List<Widget> tasks= [];
            provider.tasks.forEach((task) {
              if (task.type == "Copy") {
                tasks.add(CopyTaskCard(
                  task: task,
                  onStop: () {
                    provider.stopTask(task.id);
                  },
                ));
              }
              if (task.type == "Delete") {
                tasks.add(DeleteTaskCard(
                  task: task,
                  onStop: () {
                    provider.stopTask(task.id);
                  },
                ));
              }
            });
            return tasks;
          }
          provider.fetchData();
          return Scaffold(
            backgroundColor: Color(0xFFEEEEEE),
            appBar: AppBar(
              title: Text("Tasks"),
            ),
            body: ListView(
              children: getTaskList(),
            ),
          );
        }));
  }
}
