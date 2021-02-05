import 'package:flutter/material.dart';
import 'package:youfile/ui/home/HomePage.dart';
import 'package:youfile/ui/start/StartPage.dart';

import '../../config.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Key refreshKey;

  refresh() {
    setState(() {
      refreshKey = UniqueKey();
    });
  }
  Future<bool> check() async {
    var ok = await ApplicationConfig().checkConfig();
    if (!ok) {
      return false;
    }
    ok = await ApplicationConfig().loadConfig();
    return ok;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: check(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            if (snapshot.data) {
              return HomePage();
            } else {
              return StartPage(
                onRefresh: () {
                  refresh();
                },
              );
            }
          }
          return Container();
        });
  }
}
