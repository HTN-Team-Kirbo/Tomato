import 'package:flutter/material.dart';
import 'pages.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 40, 0),
                      child: Text(
                        "Progress",
                        textAlign: TextAlign.left,
                        style: localTheme.textTheme.headline2,
                      )),
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "X Cycles Complete",
                        textAlign: TextAlign.left,
                        style: localTheme.textTheme.bodyText2,
                      )),
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Motivational Quote",
                        textAlign: TextAlign.left,
                        style: localTheme.textTheme.bodyText2,
                      ))
                ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShowSetupPage()),
            );
          },
          child: Icon(Icons.arrow_forward),
        ));
  }
}