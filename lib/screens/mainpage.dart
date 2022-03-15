import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {

  static const String id = 'mainpage';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Main Page')),
        ),
        body: Center(
          child: MaterialButton(
            height: 50,
            minWidth: 300,
            color: Colors.green,
            onPressed: () {
              DatabaseReference dbRef =
                  FirebaseDatabase.instance.ref().child('Test');
              dbRef.set('IsConnected');
            },
            child: const Text('Test Connection'),
          ),
        ));
  }
}
