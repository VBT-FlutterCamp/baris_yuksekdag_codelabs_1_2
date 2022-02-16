import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:baris_yuksekdag_codelabs/generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Startup Name Generator",
      home: RandomWords(),
    );
  }
}
