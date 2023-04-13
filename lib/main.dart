import 'package:flutter/material.dart';
import 'package:tipti_test/app/_childrens/home/people_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Channel Flutter Demo',
      theme: ThemeData(),
      home: const PeoplePage(),
    );
  }
}
