import 'package:flutter/material.dart';

class TextInputDialog extends StatefulWidget {
  final String title;
  final String hint;
  final String okText;
  final Function(String) onOk;
  TextInputDialog({this.title,this.hint = "",this.onOk,this.okText = "OK"});
  @override
  _TextInputDialogState createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  String inputText;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title),
      contentPadding: EdgeInsets.only(
          left: 24, right: 24, bottom: 16, top: 16),
      children: [
        TextField(
          decoration:
          InputDecoration(hintText: widget.hint),
          onChanged: (text) {
            setState(() {
              inputText = text;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            children: [
              TextButton(
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.yellow),
                ),
                onPressed: (){
                  print(inputText);
                  widget.onOk(inputText);
                  Navigator.pop(context);
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        )
      ],
    );
  }
}
