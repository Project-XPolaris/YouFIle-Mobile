class UserAuth {
  String token;
  bool success;

  UserAuth({
      this.token,
      this.success,});

  UserAuth.fromJson(dynamic json) {
    token = json["token"];
    success = json["success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = token;
    map["success"] = success;
    return map;
  }

}