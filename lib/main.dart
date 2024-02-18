import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_mads_admin_panel/view/login_page.dart';
import 'package:for_mads_admin_panel/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC33a5Xp7BKdKq2Z1veTLZGety6Hk5wLdg",
          authDomain: "mads-72efc.firebaseapp.com",
          databaseURL: "https://mads-72efc-default-rtdb.firebaseio.com",
          projectId: "mads-72efc",
          storageBucket: "mads-72efc.appspot.com",
          messagingSenderId: "561213079511",
          appId: "1:561213079511:web:be2d064d2c3d82d3c49592",
          measurementId: "G-Z56QQVWE1J"
      ),
  );
  runApp(
    ScreenUtilInit(
      builder: (context, _) => MyApp(),
      designSize: const Size(375, 812),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return LoginPage();
            } else {
              return HomeScreen();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}