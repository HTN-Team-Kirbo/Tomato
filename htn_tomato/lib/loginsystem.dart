import 'package:firebase_auth/firebase_auth.dart';
import 'Components/components.dart';
import 'flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                      // use an if statement here to go to next screen?
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
                      //if statement to go to next screen?
                    }),
                child: Text("Log In")),
            Text("$errorMessage"),
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
  return SimpleDialog(children: [
    Text("Create an account"),
    RoundedInputField(
      hintText: "Email",
      icon: Icons.email,
      onChanged: (value) {
        email = value;
      },
    ),
    RoundedInputField(
      hintText: "Username",
      icon: Icons.person,
      onChanged: (value) {
        username = value;
      },
    ),
    RoundedPasswordField(
      onChanged: (value) {
        password = value;
      },
    ),
    FlatButton(
      child: Text("Create Account"),
      onPressed: () async {
        String _signupResult = await signUp(email, username, password);
        if (_signupResult == "success!") {
          //Next Screen
        }
        Navigator.pop(context, _signupResult);
      },
    ),
  ]);
}

Widget LoginDialog(BuildContext context) {
  String email;
  String password;
  return SimpleDialog(children: [
    Text("Log in to your account"),
    RoundedInputField(
      hintText: "Email",
      icon: Icons.email,
      onChanged: (value) {
        email = value;
      },
    ),
    RoundedPasswordField(
      onChanged: (value) {
        password = value;
      },
    ),
    FlatButton(
      child: Text("Log In"),
      onPressed: () async {
        String _loginResult = await login(email, password);
        if (_loginResult == "success!") {
          //Next Screen
        }
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
