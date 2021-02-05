
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:youfile/api/file.dart';
import 'package:youfile/components/FileItem.dart';
import 'package:youfile/components/FileMediumItem.dart';
import 'package:youfile/components/TextInputDialog.dart';
import 'package:youfile/ui/home/provider.dart';
import 'package:youfile/ui/task/TaskPage.dart';

class ExploreView extends StatelessWidget {
  final HomeProvider provider;

  ExploreView({this.provider});

  @override
  Widget build(BuildContext context) {
    getView() {
      onLongPress(File file) {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return FileActions(
                provider: provider,
                file: file,
              );
            });
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
              ...provider.files.map((file) {
                return FileItem(
                  name: file.name,
                  type: file.type,
                  size: file.getSizeText(),
                  onTap: () {
                    if (file.type == "Directory") {
                      provider.loadPath(file.path);
                    }
                  },
                  onLongPress: () => onLongPress(file),
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
            ...provider.files.map((file) {
              return FileMediumItem(
                name: file.name,
                type: file.type,
                onTap: () {
                  if (file.type == "Directory") {
                    provider.loadPath(file.path);
                  }
                },
                onLongPress: () => onLongPress(file),
              );
            })
          ],
        ),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, right: 16),
            height: 48,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: provider.getPathPart().length,
              separatorBuilder: (BuildContext context, int index) => Align(
                child: Padding(
                  padding: EdgeInsets.only(left: 4, right: 8),
                  child: Text("/"),
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                RoutePart item = provider.getPathPart()[index];
                return ActionChip(
                  labelPadding: EdgeInsets.only(left: 4, right: 4),
                  label: Text(
                    item.name,
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    provider.loadPath(item.path);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: getView(),
          )
        ],
      ),
    );
  }
}

List<Widget> getExploreViewActions(
    BuildContext context, HomeProvider provider) {
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
    PopupMenuButton<String>(
      icon: Icon(Icons.add),
      onSelected: (value) {
        switch (value) {
          case "new_directory":
            showDialog(
                context: context,
                child: TextInputDialog(
                  title: "Create directory",
                  okText: "create",
                  hint: "Directory name",
                  onOk: (name) {
                    provider.createDirectory(name);
                  },
                ));
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: "new_directory",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.create_new_folder),
                ),
                Text("New directory")
              ],
            ),
          ),
        ];
      },
    ),
    PopupMenuButton<String>(
      icon: Icon(Icons.reorder),
      onSelected: (value) {
        switch (value) {

        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: "name_asc",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.arrow_upward),
                ),
                Text("Name")
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: "name_desc",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.arrow_downward),
                ),
                Text("Name")
              ],
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: "type_asc",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.arrow_upward),
                ),
                Text("Type")
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: "type_desc",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.arrow_downward),
                ),
                Text("Type")
              ],
            ),
          ),
        ];
      },
    ),
  ];
  if (provider.copySource != null) {
    getIcon() {
      if (provider.copySource.type == "Directory") {
        return Icons.folder;
      }
      return Icons.description;
    }

    actions.add(PopupMenuButton<String>(
      icon: Icon(Icons.paste),
      onSelected: (value) {
        switch (value) {
          case "cancel":
            provider.setCopySource(null);
            return;
          case "paste":
            provider.newCopyTask();
            return;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            enabled: false,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(getIcon()),
              ),
              title: Text(provider.copySource.name),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: "paste",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.paste_outlined),
                ),
                Text("Paste here")
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: "cancel",
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.cancel),
                ),
                Text("Clear")
              ],
            ),
          ),
        ];
      },
    ));
  }
  actions.add(
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
    ),
  );
  return actions;
}

class FileActions extends StatelessWidget {
  final HomeProvider provider;
  final File file;

  FileActions({this.provider, this.file});

  @override
  Widget build(BuildContext context) {
    getIcon() {
      if (file.type == "Directory") {
        return Icons.folder;
      }
      return Icons.description;
    }

    renderActions() {
      List<Widget> actions = [
        ListTile(
          leading: Icon(getIcon()),
          title: Text(file.name),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text("Delete"),
          onTap: () {
            provider.remove(file.path);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.copy),
          title: Text("Copy"),
          onTap: () {
            provider.setCopySource(file);
            Navigator.pop(context);
          },
        )
      ];
      [".mp4", ".avi", ".mkv", ".mov", ".flv", ".rmvb"].forEach((ext) {
        if (file.name.endsWith(ext)) {
          actions.add(ListTile(
            leading: Icon(Icons.videocam_rounded),
            title: Text("Play video"),
            onTap: () {
              Navigator.pop(context);
              final AndroidIntent intent = AndroidIntent(
                action: 'action_view',
                data: file.getFileStream(),
                type: "video/*",
                arguments: <String, dynamic>{},
              );
              intent.launch();
            },
          ));
        }
      });
      return actions;
    }

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: renderActions(),
      );
  }
}
