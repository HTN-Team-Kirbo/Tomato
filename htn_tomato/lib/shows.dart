import 'package:flutter/material.dart';
import 'package:htn_tomato/cycles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages.dart';

APIService apiService = APIService();

class ShowSetupPage extends StatefulWidget {
  ShowSetupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShowSetupState createState() => _ShowSetupState();
}

class _ShowSetupState extends State<ShowSetupPage> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<dynamic> shows = [];

  void _searchShowTitle(String title) async {
    var foundShows = (await apiService.get(
        endpoint: '/search',
        query: {"type": "series", "limit": "9", "query": title}))["results"];
    setState(() {
      shows = foundShows;
    });
  }

  Widget _gridItemBuilder(BuildContext context, int index) {
    var show = shows[index];
    return TextButton(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(show["img"])),
        onPressed: () async {
          await Firebase.initializeApp();
          String uid = FirebaseAuth.instance.currentUser.uid;
          CollectionReference users =
              FirebaseFirestore.instance.collection('users');
          users.doc(uid).update({"show": show});

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CycleSetupPage()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(0.4, -1),
                      end: Alignment(-0.4, 1),
                      colors: [Color(0xFF1D1D42), Color(0xFF7A77F4)])),
            ),
            Container(
                alignment: Alignment(0, 1),
                child: Transform.scale(
                    scale: 1.5, child: Image.asset("assets/Saly-17.png"))),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: Text(
                      'Search for a Netflix show to watch',
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextField(
                      controller: _controller,
                      onSubmitted: (String title) async {
                        _searchShowTitle(title);
                      }),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: shows.length,
                    itemBuilder: _gridItemBuilder,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 166 / 233,
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                    ),
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
