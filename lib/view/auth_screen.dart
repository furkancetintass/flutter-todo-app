import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_todo_app/core/api/api_response.dart';
import 'package:flutter_todo_app/core/extension/context_extension.dart';
import 'package:flutter_todo_app/core/interface/auth_interface.dart';
import 'package:flutter_todo_app/core/utils/utils.dart';
import 'package:flutter_todo_app/locator.dart';
import 'package:flutter_todo_app/view/bottom.dart';
import 'package:flutter_todo_app/view/widget/button/primary_button.dart';
import 'package:flutter_todo_app/view/widget/my_text_field.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  TextEditingController emailControllerSignIn = TextEditingController();
  TextEditingController emailControllerSignUp = TextEditingController();
  TextEditingController passWordControllerSignIn = TextEditingController();
  TextEditingController passWordControllerSignUp = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final FlipCardController _flipCardController = FlipCardController();
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  Utils utils = locator<Utils>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, stops: const [
        0.3,
        0.6,
        0.7
      ], colors: [
        Colors.blue.shade900,
        Colors.blue.shade600,
        Colors.blue.shade400,
      ])),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/todo.png',
          height: 150,
        ),
        Column(
          children: const [
            Text('Giriş Yap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                )),
            Text('TODO App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                )),
          ],
        ),
        FlipCard(
          key: _cardKey,
          controller: _flipCardController,
          front: frontCard(context),
          back: backCard(context),
        )
      ]),
    ));
  }

  Card frontCard(BuildContext context) {
    var authProvider = Provider.of<AuthInterface>(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: context.dynamicHeight(0.48),
        width: context.dynamicWidth(0.9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTextField(
                  label: 'E-Posta',
                  controller: emailControllerSignIn,
                  icon: const Icon(Icons.person),
                  context: context),
              buildTextField(
                  label: 'Parola',
                  controller: passWordControllerSignIn,
                  icon: const Icon(Icons.password),
                  context: context,
                  isObsecture: true),
              PrimaryButton(
                child: authProvider.userCredential.status == Status.loading
                    ? const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white),
                        ),
                      )
                    : const Text('Giriş Yap'),
                onTap: () async {
                  await authProvider.signIn(
                      emailControllerSignIn.text, passWordControllerSignIn.text);
                  authProvider.userCredential.status == Status.completed
                      ? Navigator.pushReplacement(
                          context, CupertinoPageRoute(builder: (_) => const Bottom()))
                      : utils.showErrorSnackBar(context, authProvider.userCredential.message!);
                },
              ),
              TextButton(
                onPressed: () {
                  _cardKey.currentState!.toggleCard();
                },
                child: const Text(
                  'Üye Ol',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Text('Bunlardan birisi ile devam et',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
              SizedBox(
                height: 50,
                // width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        child: SvgPicture.asset('assets/svg/facebook.svg',
                            width: 36, color: Colors.white),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: PrimaryButton(
                        darkColor: Colors.blue,
                        lightColor: Colors.blue,
                        child: SvgPicture.asset('assets/svg/twitter.svg',
                            width: 30, color: Colors.white),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: PrimaryButton(
                        darkColor: Colors.red.shade900,
                        lightColor: Colors.redAccent,
                        child: SvgPicture.asset('assets/svg/google_plus.svg',
                            width: 30, color: Colors.white),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card backCard(BuildContext context) {
    var authProvider = Provider.of<AuthInterface>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: context.dynamicHeight(0.52),
        width: context.dynamicWidth(0.9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTextField(
                label: 'Adınız',
                controller: firstNameController,
                context: context,
              ),
              buildTextField(
                label: 'Soy Adınız',
                controller: lastNameController,
                context: context,
              ),
              buildTextField(
                  label: 'E-Posta',
                  controller: emailControllerSignUp,
                  icon: const Icon(Icons.person),
                  context: context),
              buildTextField(
                  label: 'Parola',
                  controller: passWordControllerSignUp,
                  icon: const Icon(Icons.password),
                  context: context,
                  isObsecture: true),
              PrimaryButton(
                child: authProvider.userCredential.status == Status.loading
                    ? const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white),
                        ),
                      )
                    : const Text('Kayıt Ol'),
                onTap: authProvider.userCredential.status == Status.loading
                    ? null
                    : () async {
                        await authProvider.signUp(
                            emailControllerSignUp.text, passWordControllerSignUp.text);

                        authProvider.userCredential.status == Status.completed
                            ? Navigator.pushReplacement(
                                context, CupertinoPageRoute(builder: (_) => const Bottom()))
                            : utils.showErrorSnackBar(
                                context, authProvider.userCredential.message!);
                      },
              ),
              TextButton(
                onPressed: () {
                  _flipCardController.state!.toggleCard();
                },
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
