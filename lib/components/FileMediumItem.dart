import 'package:flutter/material.dart';

class FileMediumItem extends StatelessWidget {
  final String name;
  final String type;
  final Function onTap;
  final Function onLongPress;
  FileMediumItem({this.name, this.type,this.onTap,this.onLongPress});
  @override
  Widget build(BuildContext context) {
    getIcon(){
      if (type == "Directory") {
        return Icons.folder;
      }
      return Icons.description;
    }
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Icon(getIcon(),size: 64,color: Colors.yellow.shade800,),
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
