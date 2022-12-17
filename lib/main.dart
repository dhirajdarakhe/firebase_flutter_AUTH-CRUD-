import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vb/homePage.dart';
import 'auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, s) {
          if (s.connectionState == ConnectionState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (s.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (!(s.hasData)) {
            return const Auth();
          } else {
            return const home();
          }
          }
        },
      ),
    );
  }
}

// CURD OPERATION

// import 'dart:ffi';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'FireBase Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//       print(_counter);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: StreamBuilder<List<User>>(
//           stream: readUsers(),
//           builder: (context, snapchat){
//             if(snapchat.hasError)
//             {
//               return Text("Therem is an Error");
//             }
//             else if(snapchat.hasData)
//             {
//               final users = snapchat.data!;
//               return ListView(
//                   children: users.map(buildUser).toList()
//               );
//             }
//             else{
//               return CircularProgressIndicator();
//             }
//           }
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // createData();
//           updatename();
//
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   // upade / put
//   Future updatename () async
//   {
//     final docuser = FirebaseFirestore.instance.collection("user").doc('3yAyG6qLPzwF0DLIkGPK');
//    await docuser.update({
//       'name' : 'QWERTYUIO'
//     });
//
//   }
//
//   // read / get
//   Stream<List<User>> readUsers()
//   {
//     return FirebaseFirestore.instance.collection("user").snapshots()
//         .map((snapshot) =>
//         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
//   }
//
//   Widget buildUser(User u)
//   {
//     return ListTile(
//       leading: Text( "${u.name}"),
//       title: Text("${u.id}"),
//     );
//   }
//   // POST method / write
//   Future createData() async {
//     final docUser = FirebaseFirestore.instance.collection("user").doc();
//
//     // m1
//     // final data = {
//     //   'id' : docUser.id,
//     //   'name' : 'Pranav',
//     //   'college' : 'BSV College',
//     // };
//
//     // m2
//     final user = User(id: docUser.id, name: 'sona', college: 'ooohhh');
//
//     final data = user.tojson();
//     await docUser.set(data);
//   }
// }
//
// class User {
//   String id;
//   final String name;
//   final String college;
//
//   User({this.id = "", required this.name, required this.college});
//
//   Map<String, dynamic> tojson() {
//     return {'id': id, 'name': name, 'college': college};
//   }
//   static User fromJson(Map<String, dynamic> json)
//   {
//     return User(
//       id : json['id'],
//       name : json['name'],
//       college: json['college']
//     );
//   }
// }
