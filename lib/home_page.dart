import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stack_matcher/app_colors.dart';
import 'package:stack_matcher/domain/question.dart';
import 'package:stack_matcher/infrastructure/question_buffer.dart';

import 'answer_page.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  static const _COLOR_ANIMATION_DURATION = Duration(milliseconds: 500);

  QuestionBuffer _questionBuffer = QuestionBuffer();

  List<Question> _questions = [];
  bool dragging = false;
  Color _highlightLeftColor = Colors.white;
  Color _highlightRightColor = Colors.white;

  StreamSubscription<bool> _disposable;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _questions.length > 0 ? _buildStack() : _buildProgress());
  }

  Center _buildProgress() => Center(
        child: CircularProgressIndicator(),
      );

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
        shape: _buildCardBorder(),
        elevation: (_questions.length - index).toDouble(),
        color: Colors.white,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildAuthorHeader(question),
              _buildDivider(),
              _buildPostTitle(question),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.8 - (index * 5.0),
        ),
      ),
    );
  }

  RoundedRectangleBorder _buildCardBorder() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(4),
            bottomLeft: Radius.circular(4)));
  }

  Padding _buildAuthorHeader(Question question) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
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
                style: TextStyle(
                  color: AppColors.flutterBlue,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Container(
        color: AppColors.flutterBlue,
        height: 3,
      ),
    );
  }

  Padding _buildPostTitle(Question question) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        question.title,
        style: TextStyle(fontSize: 17),
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
      var questionId = _questions[0].id;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnswerPage(title: "Answer", questionId: questionId)),
      );
    } else if (_isLeft(direction)) {
      setState(() {
        final newQuestions = _questionBuffer.nextQuestions();
        if (newQuestions.isEmpty) {
          _questions = [];
          _loadData();
        } else {
          _questions = newQuestions;
        }
      });
    }
  }

  void _loadData() {
    _disposable = _questionBuffer.loadData().listen((data) {
      setState(() {
        _questions = _questionBuffer.initialQuestions();
      });
    });
  }

  bool _isRight(double direction) => (direction > 0 && direction < pi / 2) || (direction < 0 && direction > -pi / 2);

  bool _isLeft(double direction) => (direction > pi / 2 && direction < pi) || (direction < -pi / 2 && direction > -pi);

  double _height() => MediaQuery.of(context).size.height;

  double _width() => MediaQuery.of(context).size.width;

  @override
  void dispose() {
    _disposable?.cancel();
    super.dispose();
  }
}
