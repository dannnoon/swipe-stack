import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Question> questions = [
    Question("Pierwszy"),
    Question("Drugi"),
    Question("Trzeci"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildStack());
  }

  Widget _buildStack() => Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[..._buildCards()],
        ),
      );

  List<Widget> _buildCards() {
    List<Widget> cards = List();
    for (int i = questions.length - 1; i >= 0; i--) {
      if (i > 0) {
        cards.add(_buildPositionedCard(i, questions[i]));
      } else {
        cards.add(_buildDraggableCard(i, questions[i]));
      }
    }
    print(cards);
    return cards;
  }

  Widget _buildDraggableCard(int index, Question question) => Positioned(
        top: index * 4.0,
        child: Draggable(
          child: _buildCard(index, question),
          feedback: _buildCard(index, question),
          childWhenDragging: Container(),
          onDragEnd: _onDragEnd,
          affinity: Axis.horizontal,
        ),
      );

  Widget _buildPositionedCard(int index, Question question) => Positioned(
        top: index * 4.0,
        child: _buildCard(index, question),
      );

  Widget _buildCard(int index, Question question) {
    return Padding(
      key: ValueKey(question.title),
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: (questions.length - index).toDouble(),
        color: Colors.white,
        child: Container(
          child: Text(
            question.title,
            style: TextStyle(fontSize: 20),
          ),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.8 - (index * 5.0),
        ),
      ),
    );
  }

  void _onDragEnd(DraggableDetails dragDetails) {
    final direction = dragDetails.velocity.pixelsPerSecond.direction;
    if (dragDetails.velocity.pixelsPerSecond.distance < ((_height() + _width()) / 2) * 0.2) return;
    if (_isRight(direction)) {
      setState(() {
        questions.removeAt(0);
      });
      print("Right! ###############");
    } else if (_isLeft(direction)) {
      setState(() {
        questions.removeAt(0);
      });
      print("Left! ###############");
    }
  }

  bool _isRight(double direction) => (direction > 0 && direction < pi / 2) || (direction < 0 && direction > -pi / 2);

  bool _isLeft(double direction) => (direction > pi / 2 && direction < pi) || (direction < -pi / 2 && direction > -pi);

  double _height() => MediaQuery.of(context).size.height;

  double _width() => MediaQuery.of(context).size.width;
}

class Question {
  final String title;

  Question(this.title);
}
