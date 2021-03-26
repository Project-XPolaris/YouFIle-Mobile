import 'package:flutter/material.dart';

class FileItem extends StatelessWidget {
  final String name;
  final String type;
  final String size;
  final Function onTap;
  final Function onLongPress;
  FileItem({this.name, this.type,this.size,this.onTap,this.onLongPress});

  @override
  Widget build(BuildContext context) {
    getIcon(){
      if (type == "Directory") {
        return Icons.folder;
      }
      if (type == "Parted") {
        return Icons.dns;
      }
      return Icons.description;
    }
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child:Icon(getIcon())
      ),
      title: Text(name),
      subtitle: Text("$type  $size"),
      onLongPress: onLongPress,
    );
  }
}
