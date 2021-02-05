import 'package:flutter/material.dart';
import 'package:youfile/api/info.dart';
import 'package:youfile/components/FileItem.dart';
import 'package:youfile/components/FileMediumItem.dart';
import 'package:youfile/ui/home/provider.dart';
import 'package:youfile/ui/task/TaskPage.dart';

class StartView extends StatelessWidget {
  final HomeProvider provider;

  StartView({this.provider});

  @override
  Widget build(BuildContext context) {
    provider.fetchInfo(false);
    getView() {
      print(provider.info);
      if (provider.info == null) {
        return Container();
      }
      if (provider.display == "list") {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.loadPath(null);
            return true;
          },
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              ...provider.info.rootPaths.map((RootPath rootPath) {
                return FileItem(
                  name: rootPath.name,
                  type: "Directory",
                  size: "0",
                  onTap: () {
                    provider.loadPath(rootPath.path);
                  },
                );
              })
            ],
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          await provider.loadPath(null);
          return true;
        },
        child: GridView.count(
          padding: EdgeInsets.only(top: 8),
          physics: AlwaysScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: [
            ...provider.info.rootPaths.map((RootPath rootPath) {
              return FileMediumItem(
                name: rootPath.name,
                type: "Directory",
                onTap: () {
                  provider.loadPath(rootPath.path);
                },
              );
            })
          ],
        ),
      );
    }

    return Container(
      child: getView(),
    );
  }
}

List<Widget> getStartViewActions(BuildContext context, HomeProvider provider) {
  List<Widget> actions = [
    PopupMenuButton<String>(
      icon: Icon(Icons.view_column),
      onSelected: (value) {
        provider.setDisplay(value);
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: "list",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.list_rounded),
                ),
                Text("List")
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: "medium",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.grid_view),
                ),
                Text("Medium Grid")
              ],
            ),
          )
        ];
      },
    ),
    IconButton(
      icon: Icon(
        Icons.list_alt,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskPage()),
        );
      },
    )
  ];
  return actions;
}
