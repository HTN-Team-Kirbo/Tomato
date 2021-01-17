import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<ProgressPage> {
  final workDuration = 6;
  final breakDuration = 6;
  final minute = const Duration(seconds: 1);

  int cyclesLeft = 4;
  Timer timer;
  Stopwatch stopwatch = Stopwatch();
  bool cycling = false;
  bool working = false;

  void startCycles() {
    print("starting cycles");
    setState(() {
      startWork();
      cycling = true;
    });
  }

  void startWork() {
    print("starting work");
    var duration = minute * workDuration;
    if (cyclesLeft > 0) {
      timer = new Timer(duration, startBreak);
      stopwatch.reset();
      stopwatch.start();
      setState(() {
        working = true;
        cyclesLeft--;
      });
    } else {
      stopwatch.stop();
      setState(() {
        cycling = false;
      });
    }
  }

  void startBreak() {
    print("starting break");
    var duration = minute * breakDuration;
    timer = new Timer(duration, startWork);
    stopwatch.reset();
    stopwatch.start();
    setState(() {
      working = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text(
                "Progress",
                textAlign: TextAlign.center,
                style: localTheme.textTheme.headline2,
              )),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Visibility(
                  visible: !cycling,
                  child: ElevatedButton(
                    child: Text(
                      "Start Now",
                      textAlign: TextAlign.left,
                      style: localTheme.textTheme.bodyText2,
                    ),
                    onPressed: startCycles,
                  ),
                  replacement: Text(working ? "Work Time!" : "Break Time!"))),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "$cyclesLeft Cycles Left",
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
              child: Visibility(
                  child: ElevatedButton(
                      child: Text("Congratulations! You've earned a break!",
                          textAlign: TextAlign.center,
                          style: localTheme.textTheme.bodyText2),
                      onPressed: () async {
                        await Firebase.initializeApp();
                        String uid = FirebaseAuth.instance.currentUser.uid;
                        CollectionReference users =
                            FirebaseFirestore.instance.collection('users');
                        int nfid = (await users.doc(uid).get())["show"]["nfid"];
                        print(nfid);

                        String url = 'https://www.netflix.com/watch/$nfid';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      })))
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
