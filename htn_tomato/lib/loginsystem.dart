import 'flutterfire.dart';
import 'package:flutter/material.dart';
import 'pages.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: CurvePainter(),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 200, 0, 0),
                  child: Image.asset("assets/Saly-16.png"),
                ),
                FlatButton(
                    onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return SignUpDialog(context);
                            }).then((exit) {
                          if (exit == null) return;
                          errorMessage = exit;
                          if (exit == 'success!') {
                            verifyEmail();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmationPage()),
                            );
                          }
                        }),
                    child: Text("Sign Up")),
                FlatButton(
                    onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return LoginDialog(context);
                            }).then((exit) {
                          if (exit == null) return;
                          errorMessage = exit;
                          if (exit == 'success!') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmationPage()),
                            );
                          }
                        }),
                    child: Text("Log In")),
                Text(" $errorMessage"),
              ],
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(40, 100, 40, 0),
                    child: Text(
                      "Welcome to",
                      textAlign: TextAlign.left,
                      style: localTheme.textTheme.headline1,
                    )),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Nijugo",
                      textAlign: TextAlign.left,
                      style: localTheme.textTheme.headline1
                          .apply(fontSizeFactor: 1.5),
                    )),
              ],
            )
          ]),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFF7A77F4);
    paint.style = PaintingStyle.fill;

    var path = Path();
    print("painting");
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.6, size.width, size.height * 0.4);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Widget SignUpDialog(BuildContext context) {
  String email;
  String username;
  String password;
  final node = FocusScope.of(context);
  return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Center(child: Text("Create an account")),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    icon: Icon(Icons.email),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  onEditingComplete: () => node.nextFocus(),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    icon: Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    username = value;
                  },
                  onEditingComplete: () => node.nextFocus(),
                ),
                TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password", icon: Icon(Icons.lock)),
                    onChanged: (value) {
                      password = value;
                    },
                    onSubmitted: (value) async {
                      String _signupResult =
                          await signUp(email, username, value);
                      node.unfocus();
                      Navigator.pop(context, _signupResult);
                    }),
                FlatButton(
                  child: Text("Submit"),
                  onPressed: () async {
                    String _signupResult =
                        await signUp(email, username, password);
                    Navigator.pop(context, _signupResult);
                  },
                ),
              ],
            ))
      ]);
}

Widget LoginDialog(BuildContext context) {
  String email;
  String password;

  final node = FocusScope.of(context);
  return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Center(child: Text("Log in to your account")),
              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  icon: Icon(Icons.email),
                ),
                onChanged: (value) {
                  email = value;
                },
                onEditingComplete: () => node.nextFocus(),
              ),
              TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  onSubmitted: (value) async {
                    String _loginResult = await login(email, value);
                    node.unfocus();
                    Navigator.pop(context, _loginResult);
                  }),
              FlatButton(
                child: Text("Log In"),
                onPressed: () async {
                  String _loginResult = await login(email, password);
                  Navigator.pop(context, _loginResult);
                },
              ),
              FlatButton(
                child: Text("Forgot Password? (Enter email first)"),
                onPressed: () {
                  passwordReset(email);
                },
              ),
            ],
          ),
        )
      ]);
}
