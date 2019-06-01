import 'package:stack_matcher/domain/question.dart';

class QuestionBuffer {
  List<Question> questions = [
    Question(
        "Problem 1", "9ud9aud", "www.google.com", "https://image.flaticon.com/icons/png/512/78/78373.png", "Name###"),
    Question(
        "Problem 2", "9ud9amud", "www.google.com", "https://image.flaticon.com/icons/png/512/78/78373.png", "Name###"),
    Question(
        "Problem 3", "9ud9abud", "www.google.com", "https://image.flaticon.com/icons/png/512/78/78373.png", "Name###"),
    Question(
        "Problem 4", "9ud9a2aud", "www.google.com", "https://image.flaticon.com/icons/png/512/78/78373.png", "Name###"),
    Question(
        "Problem 5", "9ud942aud", "www.google.com", "https://image.flaticon.com/icons/png/512/78/78373.png", "Name###"),
    Question(
        "Problem 6", "9ud39aud", "www.google.com", "https://image.flaticon.com/icons/png/512/78/78373.png", "Name###"),
    Question(
        "Problem 7", "9uwd9aud", "www.google.com", "https://image.flaticon.com/icons/png/512/78/78373.png", "Name###"),
  ];

  List<Question> initialQuestions() => questions.take(3).toList();

  List<Question> nextQuestions() {
    questions.removeAt(0);
    return questions.take(3).toList();
  }
}
