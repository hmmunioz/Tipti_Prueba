import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tipti_test/app/_childrens/home/people_page.dart';
import 'package:tipti_test/app/constants/texts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TextUIValues.tiptiTest,
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const PeoplePage(),
    );
  }
}
