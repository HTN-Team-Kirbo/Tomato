import 'package:flutter/material.dart';
import 'pages.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
        body: Center(
            child: Column(
                children: <Widget>[
                  Text(
                    "Check your inbox for a confirmation email!",
                    style: localTheme.textTheme.headline1,
                  ),
                  Text(
                    "Let's start setting your goals.",
                    style: localTheme.textTheme.bodyText2,
                  )
                ]
            )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShowSetupPage()),
            );
          },
          child: Icon(Icons.arrow_forward),
        )
    );

  }
}