import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youfile/ui/home/ExploreView.dart';
import 'package:youfile/ui/home/StartView.dart';

import 'provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          List<Widget> getAppBarAction() {
            if (provider.currentPath == null) {
              return getStartViewActions(context, provider);
            }
            return getExploreViewActions(context, provider);
          }

          getView() {
            if (provider.currentPath == null) {
              return StartView(
                provider: provider,
              );
            }
            return ExploreView(
              provider: provider,
            );
          }

          return WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                title: Text("YouFile"),
                actions: getAppBarAction(),
              ),
              body: getView(),
            ),
            onWillPop: () {
              if (provider.currentPath == null) {
                SystemNavigator.pop();
              }
              if (provider.goBack()) {
                provider.loadPath(null);
              } else {
                provider.currentPath = null;
                provider.notifyListeners();
              }
              return;
            },
          );
        }));
  }
}
