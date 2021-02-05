import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youfile/api/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final String title;
  final String subtitle;
  final Widget child;
  final Icon icon;
  final Function onStop;

  TaskCard(
      {this.task,
      this.title,
      this.subtitle,
      this.child,
      this.icon = const Icon(Icons.assignment),
      this.onStop});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(

        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: icon,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,softWrap: true,),
                        Text(
                          subtitle,
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      onSelected: (value) {
                        switch (value) {
                          case "stop":
                            if (onStop != null) {
                              onStop();
                            }
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: "stop",
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.cancel),
                                ),
                                Text("Stop")
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                )
              ],
            ),
            child
          ],
        ),
      ),
    );
  }
}
