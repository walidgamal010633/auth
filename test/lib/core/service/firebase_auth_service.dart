import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/core/errors/exception.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message: 'The account already exists for that email.',
        );
      } else {
        throw CustomException(message: "there is an error , please try again");
      }
    } catch (e) {
      throw CustomException(message: "Failed to create user: $e");
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      print("========================================");
      print(e.code);
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'Wrong password provided.');
      }else if (e.code == 'invalid-credential') {
        throw CustomException(message: 'Invalid credential provided.');
      }
      
       else {
        throw CustomException(message: "there is an error , please try agaim");
      }
    } catch (e) {
      throw CustomException(message: "Failed to sign in: $e");
    }
  }
}
