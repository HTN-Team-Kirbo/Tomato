import 'package:flutter/material.dart';
import 'flutterfire.dart';
import 'pages.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
          Text(
            "Check your inbox for a confirmation email!",
            style: localTheme.textTheme.headline1,
          ),
          Text(
            "Let's start setting your goals.",
            style: localTheme.textTheme.bodyText2,
          ),
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
