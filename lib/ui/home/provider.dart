import 'package:flutter/material.dart';
import 'package:youfile/api/client.dart';
import 'package:youfile/api/file.dart';
import 'package:youfile/api/info.dart';

class HomeProvider extends ChangeNotifier {
  String currentPath;
  List<File> files = [];
  bool isFirstLoad = true;
  String sep = "";
  String display = "medium";
  File copySource;
  InfoResponse info;

  loadContent() async {
    if (!isFirstLoad) {
      return;
    }
    isFirstLoad = false;
    var response = await ApiClient().readDirPath(currentPath);
    files = response.result;
    sep = response.sep;
    notifyListeners();
  }

  bool goBack() {
    if (sep.isEmpty) {
      return false;
    }
    var parts = getPathPart();
    parts.removeLast();
    if (parts.length > 0) {
      currentPath = parts.map((e) => e.name).join(sep);
      if (parts.length == 1) {
        if (!currentPath.endsWith(sep)) {
          currentPath += sep;
        }
      }
      if (parts.length == 1) {}
    } else {
      return false;
    }
    return true;
  }

  loadPath(String path) {
    if (path != null) {
      currentPath = path;
    }
    isFirstLoad = true;
    loadContent();
  }

  List<RoutePart> getPathPart() {
    if (sep.isEmpty) {
      return [];
    }
    var parts = currentPath.split(sep);
    if (parts.length > 1 && parts.last == "") {
      parts.removeLast();
    }
    List<RoutePart> routes = [];
    String cur;
    while (parts.isNotEmpty) {
      String part = parts.removeAt(0);
      if (cur == null) {
        cur = part;
        var routePath = cur;
        if (!routePath.endsWith(sep)) {
          routePath += sep;
        }
        routes.add(RoutePart(name: part, path: routePath));
        continue;
      }
      cur = [cur, part].join(sep);
      print(cur);
      routes.add(RoutePart(name: part, path: cur));
    }
    return routes;
  }

  setDisplay(String display) {
    this.display = display;
    notifyListeners();
  }

  createDirectory(String name) async {
    await ApiClient().mkdir("$currentPath$sep$name");
    loadPath(null);
    notifyListeners();
  }

  remove(String path) async {
    await ApiClient().newDeleteTask(path);
    loadPath(null);
    notifyListeners();
  }

  setCopySource(File source) {
    copySource = source;
    notifyListeners();
  }

  newCopyTask() async {
    if (copySource == null) {
      return;
    }
    await ApiClient()
        .newCopyFileTask(copySource.path, "$currentPath$sep${copySource.name}");
    setCopySource(null);
    notifyListeners();
  }

  fetchInfo(bool force) async {
    if (info != null && !force) {
      return;
    }
    info = await ApiClient().getInfo();
    notifyListeners();
  }

  remount() async {
    await ApiClient().remount();
  }
}

class RoutePart {
  String name;
  String path;

  RoutePart({this.name, this.path});
}
