import 'package:flutter/material.dart';
import 'package:stack_matcher/api/endpoints.dart';
import 'package:stack_matcher/home_page.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    getHttp();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Slack Matcher'),
    );
  }
}
