import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stack_matcher/api/Questions.dart';
import 'package:http/http.dart' as http;



var apiBaseUrl = "https://api.stackexchange.com";

Future<Questions> getHttp() async {

  Questions questions;

  try {
    var apiResponse = await http.get(apiBaseUrl + "/2.2/questions?page=1&pagesize=100&order=desc&sort=creation&tagged=flutter&site=stackoverflow");
    final jsonData = json.decode(apiResponse.body);
    questions = Questions.fromJson(jsonData);
    return questions;
  } catch (e) {
    print(e);
  }
}
