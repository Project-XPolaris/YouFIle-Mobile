import 'package:flutter/material.dart';
import 'package:youfile/api/client.dart';
import 'package:youfile/api/user_auth.dart';
import 'package:youfile/ui/home/HomePage.dart';
import 'package:youfile/utils/login_history.dart';

import '../../config.dart';

class StartPage extends StatefulWidget {
  const StartPage() : super();

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String inputUrl = "";
  String inputUsername = "";
  String inputPassword = "";
  String loginMode = "history";

  Future<bool> _init() async {
    await LoginHistoryManager().refreshHistory();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _onFinishClick() async {
      var uri = Uri.parse(inputUrl);
      if (!uri.hasScheme) {
        inputUrl  = "http://" + inputUrl;
      }
      if (!uri.hasPort) {
        inputUrl += ":8300";
      }
      print(inputUrl);
      ApplicationConfig().serviceUrl = inputUrl;
      var info = await ApiClient().fetchServiceInfo();
      if (!info.auth) {
        // without login
        ApplicationConfig().token = "";
        ApplicationConfig().username = "public";
        LoginHistoryManager().add(LoginHistory(apiUrl: inputUrl, username: "public", token: ""));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return;
      }
      // login with account
      UserAuth auth = await ApiClient().fetchUserAuth(inputUsername, inputPassword);
      if (auth.success) {
        ApplicationConfig().token = auth.token;
        ApplicationConfig().username = inputUsername;
        LoginHistoryManager().add(LoginHistory(
            apiUrl: inputUrl,
            username: inputUsername,
            token: auth.token));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onFinishClick();
        },
        backgroundColor: Colors.yellow.shade900,
        child: Icon(Icons.chevron_right),
      ),
      body: FutureBuilder(
          future: _init(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(),
                        child: Text(
                          "YouFile",
                          style: TextStyle(
                            color: Colors.yellow.shade700,
                            fontSize: 48,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 64),
                        child: Text(
                          "from ProjectXPolaris",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ),
                      Expanded(child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: TabBar(
                                indicatorColor: Colors.yellow.shade900,
                                tabs: [
                                  Tab(
                                    text: "History",
                                  ),
                                  Tab(
                                    text: "New login",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: TabBarView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                ListView(
                                  children:
                                  LoginHistoryManager().list.map((history) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: ListTile(
                                        onTap: () {
                                          var config = ApplicationConfig();
                                          config.token = history.token;
                                          config.serviceUrl = history.apiUrl;
                                          config.username = history.username;
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        },
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.yellow.shade900,
                                          child: Icon(Icons.person,color: Colors.white,),
                                        ),
                                        title: Text(history.username,),
                                        subtitle: Text(history.apiUrl,),

                                      ),
                                    );
                                  }).toList(),
                                ),
                                ListView(
                                  children: [
                                    TextField(
                                      cursorColor: Colors.yellow.shade900,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.yellow.shade900)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.yellow.shade900)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.yellow.shade900)),
                                          focusColor: Colors.yellow.shade900,
                                          hintText: 'Service URL'),
                                      onChanged: (text) {
                                        setState(() {
                                          inputUrl = text;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: TextField(
                                        cursorColor: Colors.yellow.shade900,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow.shade900)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow.shade900)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow.shade900)),
                                            focusColor: Colors.yellow.shade900,
                                            hintText: 'Username'),
                                        onChanged: (text) {
                                          setState(() {
                                            inputUsername = text;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: TextField(
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        obscureText: true,
                                        cursorColor: Colors.yellow.shade900,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow.shade900)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow.shade900)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow.shade900)),
                                            focusColor: Colors.yellow.shade900,
                                            hintText: 'Password'),
                                        onChanged: (text) {
                                          setState(() {
                                            inputPassword = text;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ))
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
    );
  }
}
