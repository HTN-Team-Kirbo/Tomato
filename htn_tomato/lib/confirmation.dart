import 'package:flutter/material.dart';
import 'flutterfire.dart';
import 'pages.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
        body: Center(
            child: Stack(
          children: [
            Container(
                alignment: Alignment(0, -0.5),
                child: Image.asset("assets/Ellipse_10.png")),
            Image.asset("assets/Saly-1.png"),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.2,
                          MediaQuery.of(context).size.height * 0.45,
                          MediaQuery.of(context).size.width * 0.2,
                          0),
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
                ]),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool verified = await emailVerified();
            if (verified) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CycleSetupPage()),
              );
            }
          },
          child: Icon(Icons.arrow_forward, color: Colors.white),
        ));
  }
}
