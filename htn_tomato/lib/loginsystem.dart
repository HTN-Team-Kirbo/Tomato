import 'package:firebase_auth/firebase_auth.dart';
import 'Components/components.dart';
import 'flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatelessWidget {
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
                    builder: (context) => SignUpDialog(context)),
                child: Text("Sign Up")),
            FlatButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => LoginDialog(context)),
                child: Text("Log In")),
          ],
        ),
      ),
    );
  }
}

Widget SignUpDialog(BuildContext context) {
  return SimpleDialog(children: [
    Text("Create an account"),
    RoundedInputField(
      hintText: "Email",
      icon: Icons.email,
      onChanged: (value) {},
    ),
    RoundedInputField(
      hintText: "Username",
      icon: Icons.person,
      onChanged: (value) {},
    ),
    RoundedPasswordField(
      onChanged: (value) {},
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
      signUp(email, password);
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
