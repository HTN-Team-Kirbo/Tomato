import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages.dart';

class CycleSetupPage extends StatefulWidget {
  CycleSetupPage({Key key}) : super(key: key);

  @override
  _CycleSetupPageState createState() => _CycleSetupPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CycleSetupPageState extends State<CycleSetupPage> {
  double currentSliderValue = 2;

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return Scaffold(
        body: Column(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 100, 40, 0),
                    child: Text(
                      "Cycles",
                      textAlign: TextAlign.center,
                      style: localTheme.textTheme.headline2,
                    )),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 60.0),
                    child: Text(
                      "Cycles are work-rest intervals timed to help you stay on-"
                      "task and productive.",
                      textAlign: TextAlign.center,
                      style: localTheme.textTheme.bodyText2,
                    )),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "How many cycles would you like to do today?",
                      textAlign: TextAlign.left,
                      style: localTheme.textTheme.bodyText2,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          alignment: Alignment(0, 0.8),
                          child: Text("1h of Work"),
                          decoration: BoxDecoration(
                              color: Color(0xFF7A77F4),
                              shape: BoxShape.rectangle)),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        alignment: Alignment(0, 0),
                        child: Text("1 Episode of Your Favourite Show",
                            textAlign: TextAlign.center),
                        decoration: BoxDecoration(
                            color: Colors.red[300], shape: BoxShape.rectangle)),
                  ),
                ),
                Slider(
                  value: currentSliderValue,
                  min: 1,
                  max: 6,
                  divisions: 5,
                  label: currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      currentSliderValue = value;
                    });
                  },
                ),
                Text(currentSliderValue.round().toString(), textScaleFactor: 3),
              ],
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Firebase.initializeApp();
            String uid = FirebaseAuth.instance.currentUser.uid;
            CollectionReference users =
                FirebaseFirestore.instance.collection('users');
            users.doc(uid).update({"max_cycles": currentSliderValue.toInt()});
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProgressPage()),
            );
          },
          child: Icon(Icons.arrow_forward, color: Colors.white),
        ));
  }
}
