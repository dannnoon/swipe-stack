import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:stack_matcher/api/Questions.dart';
import 'package:stack_matcher/api/endpoints.dart';
import 'package:stack_matcher/domain/question.dart';

class QuestionBuffer {
  int page = 0;
  List<Question> questions;
  StreamSubscription<Questions> _dataSubscription;

  Observable<bool> loadData() {
    page += 1;
    PublishSubject subject = PublishSubject<bool>();
    _dataSubscription = getHttp(page).asStream().listen((data) {
      questions = data.items
          .map(
            (item) => Question(
                  item.title,
                  item.questionId.toString(),
                  item.link,
                  item.owner.profileImage,
                  item.owner.displayName,
                ),
          )
          .toList();
      subject.add(true);
    });
    return subject.stream;
  }

  List<Question> initialQuestions() {
    if (questions == null) {
      return List(0);
    }
    return questions.take(3).toList();
  }

  List<Question> nextQuestions() {
    if (questions == null) {
      return List(0);
    }
    questions.removeAt(0);
    return questions.take(3).toList();
  }

  void dispose() {
    _dataSubscription?.cancel();
  }
}
