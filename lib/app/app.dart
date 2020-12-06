import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/views/login.view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispositivos monitorados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black87,
        primaryColor: Colors.red[900],
        primaryColorDark: Colors.black,
        cursorColor: Colors.red[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
