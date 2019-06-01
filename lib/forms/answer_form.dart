import 'package:flutter/material.dart';
import 'package:stack_matcher/api/endpoints.dart';
import 'package:stack_matcher/home_page.dart';

class AnswerForm extends StatefulWidget {
  var questionId;

  AnswerForm({this.questionId});

  @override
  AnswerFormState createState() {
    return AnswerFormState();
  }
}

class AnswerFormState extends State<AnswerForm> {
  final _formKey = GlobalKey<FormState>();
  String fieldValue;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Save someone's life!",
              style: TextStyle(
                fontSize: 20,
              )
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  minLines: 1,
                  maxLines: 10,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (String value ) {
                    this.fieldValue = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                        this._formKey.currentState.save();
                        print(widget.questionId + "   " + this.fieldValue );
                        var responseStatus = await replyQuestion(widget.questionId, this.fieldValue);
                        if (responseStatus == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(title: "Stack Matcher")),
                          );
                        }
                      }
                    },
                    child: Text('Send Answer'),
                  ),
                ),
              ],
            ),
          )
        ],
      )

    );
  }
}