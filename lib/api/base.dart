class ListResponseWrap<T> {
  int count;
  List<T> result;
  int page;
  int pageSize;

  ListResponseWrap({this.count, this.result, this.page, this.pageSize});

  ListResponseWrap.fromJson(
      Map<String, dynamic> json, Function(dynamic) converter) {
    count = json['count'];
    page = json['page'];
    pageSize = json['pageSize'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(converter(v));
      });
    }
  }
}

class BaseResponse {
  bool success;
  BaseResponse.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
  }
}