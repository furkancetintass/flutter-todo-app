import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/api/api_response.dart';

abstract class AuthInterface with ChangeNotifier {
  signUp(String email, String password);

  signIn(String email, String password);

  signOut();

  set userCredential(ApiResponse<UserCredential> value);

  ApiResponse<UserCredential> get userCredential;
}
