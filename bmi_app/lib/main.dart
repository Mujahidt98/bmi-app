import 'package:flutter/material.dart';
import 'input_page.dart';
import 'result_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Named Routes',
      routes: {
        '/home': (context) => AppBody(),
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
        ),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: AppBody(),
    );
  }
}
