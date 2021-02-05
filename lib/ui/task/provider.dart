import 'package:flutter/material.dart';
import 'package:youfile/api/client.dart';
import 'package:youfile/api/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  bool pollFlag = false;
  bool stopFlag = false;

  start() async {
    while (!stopFlag) {
      await Future.delayed(Duration(seconds: 1));
      await updateTask();
    }
  }

  stop() {
    stopFlag = true;
  }

  updateTask() async {
    tasks = await ApiClient().getTaskList();
    notifyListeners();
  }

  fetchData() async {
    if (pollFlag) {
      return;
    }
    pollFlag = true;
    updateTask();
    start();
  }

  stopTask(String id) async {
    await ApiClient().stopTask(id);
  }
}
