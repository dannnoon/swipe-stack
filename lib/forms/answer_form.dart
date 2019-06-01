import 'package:flutter/material.dart';


class AnswerForm extends StatefulWidget {
  @override
  AnswerFormState createState() {
    return AnswerFormState();
  }
}

class AnswerFormState extends State<AnswerForm> {
  final _formKey = GlobalKey<FormState>();

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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
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