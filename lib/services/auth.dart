import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:murpanara/models/app_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final userStream = FirebaseAuth.instance.authStateChanges();
  final currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Creates AppUser object from Firebase object
  AppUser _getAppUserFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : AppUser(uid: '');
  }

  // Creates AppUser stream from Firebase auth change stream
  Stream<AppUser> get userAuthState {
    return _auth
        .authStateChanges()
        .map((event) => _getAppUserFromFirebaseUser(event!));
  }

  //Sign In anon
  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user!;
      return _getAppUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In using email and password
  Future signIn({
    required TextEditingController email,
    required TextEditingController password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      User user = userCredential.user!;

      return _getAppUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e.toString());
      return (null);
    }
  }

  //Google Sign In
  Future googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new crential
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(authCredential);
      final User firebaseUser =
          (await _auth.signInWithCredential(authCredential)).user!;
      return _getAppUserFromFirebaseUser(firebaseUser);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerUser({
    required TextEditingController email,
    required TextEditingController password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User user = userCredential.user!;

      return _getAppUserFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Reset Password
  Future resetPassword({
    required TextEditingController email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.text);
    } on FirebaseAuthException catch (e) {
      print(
        e.toString(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
