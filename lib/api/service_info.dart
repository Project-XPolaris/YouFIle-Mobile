class ServiceInfo {
  bool auth;
  String name;
  bool success;
  bool youPlusPath;

  ServiceInfo({
      this.auth, 
      this.name, 
      this.success, 
      this.youPlusPath});

  ServiceInfo.fromJson(dynamic json) {
    auth = json["auth"];
    name = json["name"];
    success = json["success"];
    youPlusPath = json["youPlusPath"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["auth"] = auth;
    map["name"] = name;
    map["success"] = success;
    map["youPlusPath"] = youPlusPath;
    return map;
  }

}