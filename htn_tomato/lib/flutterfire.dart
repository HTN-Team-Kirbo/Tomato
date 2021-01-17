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

Future<String> signUp(String email, String password) async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return "success!";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return e.message;
  }
  return 'An unknown error has occurred.';
}

Future<String> login(String email, String password) async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return "success!";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return e.message;
  }
  return 'An unknown error has occurred.';
}
