import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  final databaseReference = FirebaseDatabase.instance.reference();
  late SharedPreferences prefs;

  late String userId;

  DateTime dateTime = DateTime.now();

  Future<void> createUser(String email, String username, String phone) async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId") ?? '';
    //prefs.setString("emailBackup", _email);

    databaseReference.child("users").child(userId).set({
      "email": email,
      "username": username,
      "platform": Platform.isAndroid ? "Android" : "IOS",
      "phone": phone,
      "id": userId,
    });
  }

  Future<bool> createTask(String userId, String? title, String content, String type) async {
    String taskId = databaseReference.child("tasks").child(userId).child(type).push().key;
    try {
      databaseReference
          .child("tasks")
          .child(userId)
          .child(type)
          .child(taskId)
          .set({"title": title , "content": content});
      return true;
    } catch (e) {
      debugPrint('create task fonk hata');
      return false;
    }
  }
}
