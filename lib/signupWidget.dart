import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vb/main.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  final VoidCallback onClickedsSignIn;
  const SignUp({Key? key, required this.onClickedsSignIn}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userEmail = TextEditingController();
  final userPwd = TextEditingController();
  final fkey = GlobalKey<FormState>();
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
        title: const Text("crreate account"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 45),
              TextFormField(
                controller: userEmail,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty ){
                    return 'Please enter some text';
                  }else if(!EmailValidator.validate(value))
                  {
                    return 'Please enter Correct Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: userPwd,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'pwd'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if(value.length < 6)
                    {
                      return 'Please enter 6 char pwd';
                    }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                // onPressed: signIN,
                label: const Text(
                  "SignUP",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                icon: const Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                onPressed: SignUP,
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black87, fontSize: 25),
                    text: "I've alrdy Acc   ",
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedsSignIn,
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
      ),
    );
  }

  Future SignUP() async {
    if(!fkey.currentState!.validate()) return;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const CircularProgressIndicator());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail.text.trim(), password: userPwd.text.trim());
    } on FirebaseAuthException catch (e) {
      print("Error : $e");
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
