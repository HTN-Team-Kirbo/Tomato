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
  final workMinutes = 6;
  final breakMinutes = 6;
  final minute = const Duration(seconds: 1);

  int cyclesLeft = 1;
  Timer timer;
  Stopwatch stopwatch = Stopwatch();
  bool cycling = false;
  bool working = false;
  double barLength = 0;

  void startCycles() async {
    await Firebase.initializeApp();
    String uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    int _maxCycles = (await users.doc(uid).get())["max_cycles"];
    setState(() {
      cyclesLeft = _maxCycles;
      startWork();
      cycling = true;
    });
  }

  void startWork() {
    var duration = minute * workMinutes;
    if (cyclesLeft > 0) {
      timer = new Timer(duration, startBreak);
      stopwatch.reset();
      stopwatch.start();
      setState(() {
        working = true;
        barLength = 300;
        cyclesLeft--;
      });
    } else {
      stopwatch.stop();
      setState(() {
        cycling = false;
      });
    }
  }

  void startBreak() async {
    Widget breakDia = await breakDialog(context);
    showDialog(
        context: context,
        builder: (context) {
          return breakDia;
        });
    var duration = minute * breakMinutes;
    timer = new Timer(duration, startWork);
    stopwatch.reset();
    stopwatch.start();
    setState(() {
      working = false;
      barLength = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(-0.3, 1),
                  end: Alignment(0.3, -1),
                  colors: [Color(0xFF1D1D42), Color(0xFF7A77F4)])),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        replacement:
                            Text(working ? "Work Time!" : "Break Time!"))),
                Image.asset("assets/Saly-10.png"),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AnimatedContainer(
                      color: Colors.green,
                      duration: minute * (working ? workMinutes : breakMinutes),
                      height: 10,
                      width: barLength),
                ),
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
              ])),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShowSetupPage()),
            );
          },
          child: Icon(Icons.arrow_forward, color: Colors.white),
        ));
  }
}

Future<Widget> breakDialog(BuildContext context) async {
  await Firebase.initializeApp();
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  try {
    var show = (await users.doc(uid).get())["show"];
  } catch (e) {
    return ShowSetupPage();
  }
  var show = (await users.doc(uid).get())["show"];
  String title = show["title"];
  int nfid = show["nfid"];

  final node = FocusScope.of(context);
  return SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    children: [
      Center(
          child: Text(
        "Congratulations! You've earned a break!",
        style: Theme.of(context).textTheme.bodyText2,
      )),
      ElevatedButton(
          child: Text(
            "Open $title on Netflix",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onPressed: () async {
            String url = 'https://www.netflix.com/watch/$nfid';
            if (await canLaunch(url)) {
              await launch(url);
              node.unfocus();
            } else {
              throw 'Could not launch $url';
            }
          })
    ],
  );
}
