import 'dart:async';

import 'package:cab_rider/screens/loginpage.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/screens/registrationpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'helpers/PlatformInfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (PlatformInfo().getCurrentPlatformType() == PlatformType.Android) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyA2KC9TCv0kDeqHm6jlFZMY5Swo7LeyDyY',
        appId: '1:192384878752:android:7b786a3db4af12136361c5',
        databaseURL:
            'https://cabrider-25b7f-default-rtdb.asia-southeast1.firebasedatabase.app',
        storageBucket: 'cabrider-25b7f.appspot.com',
        messagingSenderId: '192384878752',
        projectId: 'cabrider-25b7f',
      ),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            fontFamily: "Brand-Regular"),
        initialRoute: MainPage.id,
        routes: {
          RegistrationPage.id: (context) => const RegistrationPage(),
          LoginPage.id: (context) => const LoginPage(),
          MainPage.id: (context) => const MainPage(),
        });
  }
}
