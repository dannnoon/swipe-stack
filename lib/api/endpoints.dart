import 'package:dio/dio.dart';


var apiBaseUrl = "https://api.stackexchange.com";

void getHttp() async {
  try {
    Response response = await Dio().get(apiBaseUrl + "/2.2/questions?page=1&pagesize=100&order=desc&sort=creation&tagged=flutter&site=stackoverflow");
    print(response);
  } catch (e) {
    print(e);
  }
}
