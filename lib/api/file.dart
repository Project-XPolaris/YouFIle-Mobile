import 'package:filesize/filesize.dart';
import 'package:youfile/config.dart';

class FileListResponse {
  String sep;
  List<File> result;

  FileListResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic) converter) {
    sep = json["sep"];
    if (json['result'] != null) {
      result = new List<File>();
      json['result'].forEach((v) {
        result.add(File.fromJson(v));
      });
    }
  }
}

class File {
  String name;
  String type;
  String path;
  int size;

  File.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    path = json['path'];
    size = json['size'];
  }

  String getSizeText() {
    if (type == "Directory") {
      return "";
    }
    return filesize(this.size);
  }
  String getFileStream(){
    return "${ApplicationConfig().serviceUrl}/files?target=$path";
  }
}
