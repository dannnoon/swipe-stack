import 'package:flutter/material.dart';
import 'package:stack_matcher/api/endpoints.dart';
import 'package:stack_matcher/oauth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OauthPage()
//      home: HomePage(title: 'Slack Matcher'),
        );
  }
}
