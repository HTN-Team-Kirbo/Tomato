import 'package:flutter/material.dart';
import 'flutterfire.dart';
import 'pages.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Text(
                    "Check your inbox for a confirmation email!",
                    textAlign: TextAlign.center,
                    style: localTheme.textTheme.headline2,
                  )),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Let's start setting your goals.",
                    textAlign: TextAlign.center,
                    style: localTheme.textTheme.bodyText2,
                  )),
              FlatButton(
                onPressed: () async {
                  verifyEmail();
                },
                child: Text("Resend Verification Email"),
              )
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool verified = await emailVerified();
            if (verified) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowSetupPage()),
              );
            }
          },
          child: Icon(Icons.arrow_forward),
        ));
  }
}
