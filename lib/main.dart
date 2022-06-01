import 'package:flutter/material.dart';
import 'Home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Toko Test App",
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}
