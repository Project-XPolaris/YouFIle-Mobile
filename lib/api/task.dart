import 'package:filesize/filesize.dart';

class Task {
  String id;
  String type;
  String status;
  dynamic output;

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    if (type == "Copy") {
      output = CopyFileTaskOutput.fromJson(json["output"]);
    }
    if (type == "Delete") {
      output = DeleteFileTaskOutput.fromJson(json["output"]);
    }
  }
}

class CopyItem {
  String src;
  String dest;

  CopyItem.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    dest = json['dest'];
  }
}

class CopyFileTaskOutput {
  int totalLength;
  int fileCount;
  int complete;
  int completeLength;
  String currentCopy;
  double progress;
  int speed;
  List<CopyItem> list;

  CopyFileTaskOutput.fromJson(Map<String, dynamic> json) {
    totalLength = json['total_length'];
    fileCount = json['file_count'];
    complete = json['complete'];
    completeLength = json["complete_length"];
    currentCopy = json["current_copy"];
    if (json["progress"] is int) {
      progress = json["progress"].toDouble();
    } else {
      progress = json["progress"];
    }
    speed = json["speed"];
    list = [];
    json['list'].forEach((v) {
      list.add(CopyItem.fromJson(v));
    });
  }

  String getProgressText() {
    return "${(this.progress * 100).toInt()}%";
  }

  String getSpeedText() {
    return "${filesize(speed)}/s";
  }

  String getTotalLength() {
    return filesize(totalLength);
  }

  String getCompleteLength() {
    return filesize(completeLength);
  }

  String getTaskName() {
    if (list.length == 1) {
      return list.first.dest;
    }
    return "${list.first.dest} and ${list.length - 1} other items";
  }
}

class DeleteFileTaskOutput {
  int fileCount;
  int complete;
  double progress;
  String currentDelete;
  List<String> src;

  DeleteFileTaskOutput.fromJson(Map<String, dynamic> json) {
    fileCount = json['file_count'];
    complete = json['complete'];
    currentDelete = json["current_delete"];
    if (json["progress"] is int) {
      progress = json["progress"].toDouble();
    } else {
      progress = json["progress"];
    }
    src = [];
    json['src'].forEach((v) {
      src.add(v);
    });
  }

  String getTaskName(){
    if (src.length == 1) {
      return src.first;
    }
    return "${src.first} and other ${src.length - 1} items";
  }
  String getProgressText() {
    return "${(this.progress * 100).toInt()}%";
  }
}
