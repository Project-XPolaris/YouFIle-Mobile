import 'package:flutter/material.dart';
import 'package:youfile/api/task.dart';
import 'package:youfile/components/TaskCard.dart';

class CopyTaskCard extends StatelessWidget {
  final Task task;
  final Function onStop;
  CopyTaskCard({this.task,this.onStop});

  @override
  Widget build(BuildContext context) {
    CopyFileTaskOutput output = task.output;
    return TaskCard(
      title: output.getTaskName(),
      subtitle: "Copy | ${task.status}",
      icon: Icon(Icons.copy),
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
                          Icon(Icons.speed),
                          Text(output.getSpeedText())
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          Icon(Icons.import_export),
                          Text(
                              "${output.getCompleteLength()} / ${output.getTotalLength()}")
                        ],
                      ),
                    ),
                    flex: 2,
                  ),
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
            child: Text(output.currentCopy),
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
