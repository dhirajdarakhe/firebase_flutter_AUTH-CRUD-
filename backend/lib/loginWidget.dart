import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vb/fogotPwdWidget.dart';
import 'package:vb/main.dart';

class LogIn extends StatefulWidget {
  final VoidCallback onClickedsSignUp;
  const LogIn({Key? key, required this.onClickedsSignUp}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final userEmail = TextEditingController();
  final userPwd = TextEditingController();

  @override
  void dispose() {
    userEmail.dispose();
    userPwd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("enter into account"),
      ),
      body : SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 45),
            TextField(
              controller: userEmail,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: userPwd,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'pwd'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              // onPressed: signIN,
              label: const Text(
                "SignIN",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              icon: const Icon(
                Icons.lock_open,
                size: 32,
              ),
              onPressed: SignIN,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text("forgot pwd", style: TextStyle(
                decoration:  TextDecoration.underline,
                fontSize: 20,
              ),),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => forgotPwd()))
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 25),
                  text: "No Acc ?  ",
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedsSignUp,
                        text: 'Sign Up',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                            fontSize: 20))
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Future SignIN() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const CircularProgressIndicator());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail.text.trim(), password: userPwd.text.trim());
    } on FirebaseAuthException catch (e) {
      print("Error : $e");
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
