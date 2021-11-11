import 'package:flutter/material.dart';
import 'package:flutter_todo_app/view/widget/success_snackbar.dart';

class Utils {
  showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(mySnackBar());
  }
  showErrorSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(myErrorSnackBar(message));
  }
}
