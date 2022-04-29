import 'package:flutter/material.dart';

import '../services/auth_form.dart';
import '../widgets/base_ui.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: BaseUI(
          padding: const EdgeInsets.only(left: 18, top: 20),
          text1: 'Flutter',
          text2: 'App',
          fontWeight1: FontWeight.w900,
          fontsize1: 50,
          height: 100,
          radius: const BorderRadius.only(
            topLeft: Radius.circular(40),
          ),
          fontsize2: 50,
          fontWeight2: FontWeight.w500,
          child: const AuthForm(),
        ),
      ),
    );
  }
}
