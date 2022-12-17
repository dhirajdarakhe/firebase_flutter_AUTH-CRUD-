import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vb/main.dart';

class forgotPwd extends StatefulWidget {
  const forgotPwd({Key? key}) : super(key: key);

  @override
  _forgotPwdState createState() => _forgotPwdState();
}

class _forgotPwdState extends State<forgotPwd> {
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
        title: const Text("make new pwd"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Receive an email to rreset your email"),
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
              ElevatedButton.icon(
                // onPressed: signIN,
                label: const Text(
                  "Reset pwd",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                icon: const Icon(
                  Icons.alternate_email,
                  size: 32,
                ),
                onPressed: Resetemail,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future Resetemail() async
  {
    if(!fkey.currentState!.validate()) return;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const CircularProgressIndicator());
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail.text.trim());

    } on FirebaseAuthException catch(e)
    {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }
}
