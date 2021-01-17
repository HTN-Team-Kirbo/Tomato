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
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
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
                              builder: (context) => ConfirmationPage()
                          ),
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
                              builder: (context) => ConfirmationPage()
                          ),
                        );
                      }
                    }),
                child: Text("Log In")),
            Text(" $errorMessage"),
          ],
        ),
      ),
    );
  }
}

Widget SignUpDialog(BuildContext context) {
  String email;
  String username;
  String password;
  final node = FocusScope.of(context);
  return SimpleDialog(children: [
    Text("Create an account"),
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
        decoration:
            InputDecoration(hintText: "Password", icon: Icon(Icons.lock)),
        onChanged: (value) {
          password = value;
        },
        onSubmitted: (value) async {
          String _signupResult = await signUp(email, username, value);
          node.unfocus();
          Navigator.pop(context, _signupResult);
        }),
    FlatButton(
      child: Text("Create Account"),
      onPressed: () async {
        String _signupResult = await signUp(email, username, password);
        Navigator.pop(context, _signupResult);
      },
    ),
  ]);
}

Widget LoginDialog(BuildContext context) {
  String email;
  String password;

  final node = FocusScope.of(context);
  return SimpleDialog(children: [
    Text("Log in to your account"),
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
  ]);
}
