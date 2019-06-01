import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stack_matcher/app_colors.dart';
import 'package:stack_matcher/domain/question.dart';
import 'package:stack_matcher/infrastructure/question_buffer.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  static const _COLOR_ANIMATION_DURATION = Duration(milliseconds: 500);
  final QuestionBuffer _questionBuffer = QuestionBuffer();

  List<Question> _questions = [];
  bool dragging = false;
  Color _highlightLeftColor = Colors.white;
  Color _highlightRightColor = Colors.white;

  @override
  void initState() {
    _questions = _questionBuffer.initialQuestions();
    super.initState();
  }

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
          children: <Widget>[
            _buildBackground(),
            ..._buildCards(),
          ],
        ),
      );

  Widget _buildBackground() => Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: AnimatedContainer(
              duration: _COLOR_ANIMATION_DURATION,
              color: _highlightLeftColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: AnimatedContainer(
              duration: _COLOR_ANIMATION_DURATION,
              color: _highlightRightColor,
            ),
          ),
        ],
      );

  List<Widget> _buildCards() {
    List<Widget> cards = List();
    for (int i = _questions.length - 1; i >= 0; i--) {
      if (i > 0) {
        cards.add(_buildPositionedCard(i, _questions[i]));
      } else {
        cards.add(_buildDraggableCard(i, _questions[i]));
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
          onDragStarted: () {
            setState(() {
              _highlightLeftColor = AppColors.redHighlight;
              _highlightRightColor = AppColors.greenHighlight;
            });
          },
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
        elevation: (_questions.length - index).toDouble(),
        color: Colors.white,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Post author"),
                Row(
                  children: <Widget>[
                    Image(
                      width: 48,
                      height: 48,
                      image: NetworkImage(question.avatarUrl),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          question.authorName,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: AppColors.flutterBlue,
                  height: 2,
                ),
                Text(
                  question.title,
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.8 - (index * 5.0),
        ),
      ),
    );
  }

  void _onDragEnd(DraggableDetails dragDetails) {
    setState(() {
      _highlightLeftColor = Colors.white;
      _highlightRightColor = Colors.white;
    });

    final direction = dragDetails.velocity.pixelsPerSecond.direction;
    if (dragDetails.velocity.pixelsPerSecond.distance < ((_height() + _width()) / 2) * 0.2) return;

    if (_isRight(direction)) {
    } else if (_isLeft(direction)) {
      setState(() {
        _questions = _questionBuffer.nextQuestions();
      });
    }
  }

  bool _isRight(double direction) => (direction > 0 && direction < pi / 2) || (direction < 0 && direction > -pi / 2);

  bool _isLeft(double direction) => (direction > pi / 2 && direction < pi) || (direction < -pi / 2 && direction > -pi);

  double _height() => MediaQuery.of(context).size.height;

  double _width() => MediaQuery.of(context).size.width;
}
