import 'package:flutter/material.dart';
import 'package:frivia/pages/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frivia',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 2, 156, 156),
        fontFamily: 'Preahvihear',
        useMaterial3: true,
      ),
      home: StartPage(),
    );
  }
}
