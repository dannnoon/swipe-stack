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

Future<String> authenticate(String code) async {
  final dio = new Dio();
  final response = await dio.post(
    "https://stackoverflow.com/oauth/access_token/json",
    data: {
      "client_id": "15469",
      "client_secret": "A2tApnThiDvQvu3o9e3E6A((",
      "code": code,
      "redirect_uri": "https://example.com",
    },
  );
  return response.data.toString();
}

class OauthRequest {
  final String client_id;
  final String client_secret;
  final String code;
  final String redirect_uri;

  OauthRequest(this.client_id, this.client_secret, this.code, this.redirect_uri);
}
