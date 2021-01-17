import 'package:flutter/material.dart';
import 'pages.dart';

class CycleSetupPage extends StatelessWidget {
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
                    "Cycles",
                    textAlign: TextAlign.left,
                    style: localTheme.textTheme.headline2,
                  )),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "The cycles you set up are intervals that you plan "
                    "to accomplish your tasks within the day.",
                    textAlign: TextAlign.left,
                    style: localTheme.textTheme.bodyText2,
                  )),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "How many cycles would you like to do today?",
                    textAlign: TextAlign.left,
                    style: localTheme.textTheme.bodyText2,
                  ))
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProgressPage()),
            );
          },
          child: Icon(Icons.arrow_forward),
        ));
  }
}
