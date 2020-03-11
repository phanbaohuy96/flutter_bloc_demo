import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/ui/screens/splash_creens.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Demo',
      home: Container(
        color: Theme.of(context).primaryColor,
        child: SplashScreen(),
      ),
    );
  }
}
