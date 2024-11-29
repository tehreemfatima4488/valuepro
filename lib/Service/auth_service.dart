import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<UserCredential> signUp(
      String email,
      String password,
      String name
      ) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      // Add additional user info to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('An account already exists for this email.');
      }
      rethrow;
    }
  }


  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email,
      String password
      ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      if (e.code == 'user-not-found') {
        throw Exception('No user found for this email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Incorrect password.');
      }
      rethrow;
    }
  }
  //
  // // Sign up with email and password
  // Future<UserCredential> signUp(
  //     String email,
  //     String password
  //     ) async {
  //   try {
  //     return await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       throw Exception('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       throw Exception('An account already exists for this email.');
  //     }
  //     rethrow;
  //   }
  // }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}