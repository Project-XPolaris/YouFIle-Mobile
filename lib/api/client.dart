import 'package:dio/dio.dart';
import 'package:youfile/api/base.dart';
import 'package:youfile/api/file.dart';
import 'package:youfile/api/info.dart';
import 'package:youfile/api/service_info.dart';
import 'package:youfile/api/task.dart';
import 'package:youfile/api/user_auth.dart';

import '../config.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  static Dio _dio = new Dio();

  factory ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        options.baseUrl = ApplicationConfig().serviceUrl;
        String token = ApplicationConfig().token;
        if (token != null && token.isNotEmpty) {
          options.headers = {
            "Authorization": "Bearer $token"
          };
        }
        return options; //continue
      },
    ));
    return _instance;
  }

  Future<FileListResponse> readDirPath(String dirpath) async {
    var response =
        await _dio.get("/path/read", queryParameters: {"readPath": dirpath});
    FileListResponse responseBody =
        FileListResponse.fromJson(response.data, (data) => File.fromJson(data));
    return responseBody;
  }

  Future<void> mkdir(String path) async {
    await _dio
        .post("/path/mkdir", queryParameters: {"dirPath": path, "perm": 0775});
  }

  Future<void> remove(String path) async {
    await _dio.post("/path/remove", queryParameters: {"target": path});
  }

  Future<void> newCopyFileTask(String src, String dest) async {
    await _dio.post("/task/copy", data: {
      "list": [
        {"src": src, "dest": dest}
      ]
    });
  }

  Future<void> newDeleteTask(String deletePath) async {
    await _dio.post("/task/delete", data: {
      "list": [deletePath]
    });
  }

  Future<List<Task>> getTaskList() async {
    var response = await _dio.get("/task/all");
    List<Task> tasks = [];
    response.data["result"].forEach((raw) {
      tasks.add(Task.fromJson(raw));
    });
    return tasks;
  }

  Future<void> stopTask(String id) async {
    await _dio.post("/task/stop", queryParameters: {"taskId": id});
  }

  Future<InfoResponse> getInfo() async {
    var response = await _dio.get("/info");
    return InfoResponse.fromJson(response.data);
  }

  Future<BaseResponse> remount() async {
    var response = await _dio.get("/fstab/reload");
    return BaseResponse.fromJson(response.data);
  }
  Future<ServiceInfo> fetchServiceInfo() async {
    var response = await _dio.get("/service/info");
    return ServiceInfo.fromJson(response.data);
  }
  Future<UserAuth> fetchUserAuth(String username,String password)async {
    var response = await _dio.post("/user/auth",data: {"username":username,"password":password});
    return UserAuth.fromJson(response.data);
  }
  ApiClient._internal();
}
