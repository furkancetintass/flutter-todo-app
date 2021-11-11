import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/extension/context_extension.dart';
import 'package:flutter_todo_app/view/auth_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // elimizde servis olmadığı için inital request atamadım ve manuel bir duration verdim
    Future.delayed(const Duration(milliseconds: 2600), () {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) =>  AuthScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: context.dynamicWidth(1),
      height: context.dynamicHeight(1),
      child: Lottie.asset(
        'assets/lottie/splash.json',
        fit: BoxFit.fill,
      ),
    );
  }
}
