import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/interface/auth_interface.dart';
import 'package:flutter_todo_app/core/service/auth_service.dart';
import 'package:flutter_todo_app/core/theme/my_theme.dart';
import 'package:flutter_todo_app/locator.dart';
import 'package:flutter_todo_app/view/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthInterface>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
