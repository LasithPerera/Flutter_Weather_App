import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
    
          secondary: Colors.lightBlueAccent, 
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, 
    );
  }
}
