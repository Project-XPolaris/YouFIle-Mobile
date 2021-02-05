import 'package:flutter/material.dart';
import 'package:youfile/api/task.dart';
import 'package:youfile/components/TaskCard.dart';

class DeleteTaskCard extends StatelessWidget {
  final Task task;
  final Function onStop;
  DeleteTaskCard({this.task,this.onStop});
  @override
  Widget build(BuildContext context) {
    DeleteFileTaskOutput output = task.output;

    return TaskCard(
      title: output.getTaskName(),
      subtitle: "Delete | ${task.status}",
      icon: Icon(Icons.delete),
      onStop: onStop,
      child: Column(
        children: [
          Container(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          Icon(Icons.description),
                          Text("${output.complete} / ${output.fileCount}")
                        ],
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 8, bottom: 4),
            child: Text(output.currentDelete),
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(value: output.progress),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(output.getProgressText()),
              )
            ],
          )
        ],
      ),
    );
  }
}
