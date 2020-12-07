import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/views/login.view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispositivos monitorados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white10,
        primaryColor: Colors.deepOrangeAccent,
        primaryColorDark: Colors.white,
        cursorColor: Colors.orangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.deepOrange,
      ),
      home: LoginPage(),
    );
  }
}
