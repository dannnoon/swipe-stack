import 'package:flutter/material.dart';
import 'package:stack_matcher/forms/answer_form.dart';

class AnswerPage extends StatefulWidget {
  final String title;

  AnswerPage({this.title});

  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnswerForm(),
    );
  }
}
