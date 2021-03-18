import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WikiPediaSarch',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.transparent,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              brightness: Brightness.light
          )
      ),
      home:SplashScreen(),
    );
  }
}

