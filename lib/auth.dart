import 'package:flutter/material.dart';
import 'package:vb/signupWidget.dart';
import 'loginWidget.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    // return isLogin ? LogIn(onClick : toggle) : SignUp(onClick : toggle);
    return isLogin
        ? LogIn(onClickedsSignUp: toggle)
        : SignUp(onClickedsSignIn: toggle);
  }

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
