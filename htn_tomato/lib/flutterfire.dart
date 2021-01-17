import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> checkAuth() async {
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    print("Already signed in");
  } else {
    print("Signed Out");
  }
}

Future<String> signUp(String email, String username, String password) async {
  await Firebase.initializeApp();

  try {
    //print(email);
    //print(password);
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .add({
          'username': username, // John Doe
          'friends': [],
          'total_cycles': 0,
          'coins': 0,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    return "success!";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else {
      return 'An unknown error has occurred.';
    }
  }
}

Future<String> login(String email, String password) async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return "success!";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for this account.';
    } else {
      return 'An unknown error has occurred.';
    }
  }
}

Future<bool> verifyEmail() async {
  await Firebase.initializeApp();
  User user = FirebaseAuth.instance.currentUser;

  if (user.emailVerified) {
    return true;
  } else {
    await user.sendEmailVerification();
    return false;
  }
}

Future<void> passwordReset(String email) async {
  await Firebase.initializeApp();

  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
