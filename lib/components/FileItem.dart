import 'package:flutter/material.dart';
import 'package:youfile/utils/icon.dart';

class FileItem extends StatelessWidget {
  final String name;
  final String type;
  final String size;
  final Function onTap;
  final Function onLongPress;
  FileItem({this.name, this.type,this.size,this.onTap,this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image(image: getFileIcon(type, name),width: 36,height: 36,),
      title: Text(name),
      subtitle: Text("$type  $size"),
      onLongPress: onLongPress,
    );
  }
}
