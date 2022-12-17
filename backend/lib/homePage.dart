import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final userInfo = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Loged IN"),
                // Text(userInfo.email!),
                ElevatedButton.icon(
                  // onPressed: signIN,
                  label: const Text(
                    "Sign out",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  icon: const Icon(
                    Icons.lock_reset,
                    size: 32,
                  ), onPressed: ()  => FirebaseAuth.instance.signOut(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
