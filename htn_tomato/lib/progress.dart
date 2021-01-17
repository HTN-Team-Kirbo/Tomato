import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                  )),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      child: Text("Congratulations! You've earned a break!",
                          textAlign: TextAlign.center,
                          style: localTheme.textTheme.bodyText2),
                    onPressed: () async {

                      await Firebase.initializeApp();
                      String uid = FirebaseAuth.instance.currentUser.uid;
                      CollectionReference users = FirebaseFirestore.instance.collection('users');
                      int nfid = (await users.doc(uid).get())["show"]["nfid"];
                      print(nfid);

                      String url = 'https://www.netflix.com/watch/$nfid';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }
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
