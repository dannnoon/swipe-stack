import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_view/flutter_web_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_matcher/api/endpoints.dart';
import 'package:stack_matcher/home_page.dart';

class OauthPage extends StatefulWidget {
  @override
  _OauthPageState createState() => _OauthPageState();
}

class _OauthPageState extends State<OauthPage> {
  FlutterWebView _flutterWebView = FlutterWebView();

  @override
  void initState() {
    _flutterWebView.onToolbarAction.listen((identifier) {
      switch (identifier) {
        case 1:
          _flutterWebView.dismiss();
          break;
      }
    });
    _flutterWebView.listenForRedirect("https://example.com", true);

    _flutterWebView.onRedirect.listen(_handleRedirect);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          onPressed: _onPress,
          child: Text("OAuth"),
        ),
      ),
    );
  }

  void _onPress() {
//    if (!_flutterWebView.isLaunched) {
    _flutterWebView.launch(
        "https://stackoverflow.com/oauth?client_id=15469&scope=write_access+no_expiry&redirect_uri=https://example.com",
        headers: {
          "User-agent":
              "Mozilla/5.0 (Linux; Android 4.4.2; Nexus 4 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.114 Mobile Safari/537.36",
        },
        javaScriptEnabled: true,
        toolbarActions: [new ToolbarAction("Dismiss", 1)],
        barColor: Colors.blue,
        tintColor: Colors.white);
//    }
  }

  void _handleRedirect(String event) {
    debugPrint("Redirect $event");
    final code = event.replaceFirst("https://example.com/?code=", "");
    sendCode(code);
    _flutterWebView.dismiss();
  }

  void sendCode(String code) {
    authenticate(code).then(_storeAccessToken).then(_navigateToHome);
  }

  Future<FutureOr> _storeAccessToken(String value) async {
    debugPrint("accessToken $value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', value);
  }

  FutureOr _navigateToHome(FutureOr value) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(title: 'Stack Matcher')),
    );
  }
}
