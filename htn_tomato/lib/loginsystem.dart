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
                      print(exit);
                      if (exit == null) return;
                      if (exit == "success!") {
                        setState(() {
                          errorMessage = exit;
                        });
                      } else {
                        setState(() {
                          errorMessage = exit;
                        });
                      }
                    }),
                child: Text("Sign Up")),
            FlatButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => LoginDialog(context)),
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
        String _signupResult = await signUp(email, password);
        if (_signupResult == "success!") {
          //Next Screen
        }
        Navigator.pop(context, _signupResult);
      },
    ),
  ]);
}

Widget LoginDialog(BuildContext context) {
  return SimpleDialog(children: [
    Text("Log in to your account"),
    RoundedInputField(
      hintText: "Email",
      icon: Icons.email,
      onChanged: (value) {},
    ),
    RoundedPasswordField(
      onChanged: (value) {},
    ),
    FlatButton(
      child: Text("Log In"),
      onPressed: () {},
    ),
    FlatButton(
      child: Text("Forgot Password?"),
      onPressed: () {},
    ),
  ]);
}

class AddUser extends StatelessWidget {
  final String username;
  final String email;
  final String password;

  AddUser(this.username, this.email, this.password);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'username': username, // John Doe
            'friends': [],
            'total_cycles': 0,
            'coins': 0,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}
