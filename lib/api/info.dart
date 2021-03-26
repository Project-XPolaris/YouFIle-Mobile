class InfoResponse {
  String sep;
  List<RootPath> rootPaths;

  InfoResponse.fromJson(Map<String, dynamic> json) {
    sep = json['sep'];
    rootPaths = [];
    json['root_paths'].forEach((v) {
      rootPaths.add(RootPath.fromJson(v));
    });
  }

}

class RootPath {
  String path;
  String name;
  String type;
  RootPath.fromJson(Map<String, dynamic> json) {
    path = json["path"];
    name = json["name"];
    type = json["type"];
  }
}