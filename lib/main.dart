import 'package:flutter/material.dart';
import 'package:tell_me/screens/home_screen.dart';
import 'package:tell_me/screens/image_screen.dart';
import 'package:tell_me/services/news_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
