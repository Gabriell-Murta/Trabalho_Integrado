import 'package:flutter/material.dart';
import 'package:mvc_persistence/app/views/login.view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Fechaduras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white10,
        primaryColor: Colors.deepPurple,
        primaryColorDark: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.purple, 
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
      ),
      home: LoginPage(),
    );
  }
}
