import 'package:flutter/material.dart';
import 'package:youfile/utils/icon.dart';

class FileMediumItem extends StatelessWidget {
  final String name;
  final String type;
  final Function onTap;
  final Function onLongPress;
  FileMediumItem({this.name, this.type,this.onTap,this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 56,
                    height: 56,
                  child: Image(image: getFileIcon(type, name),width: 56,),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Text(name,maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: true,textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
