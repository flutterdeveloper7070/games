import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  String gamesUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gamesUrl = window.localStorage['gamesUrl'] ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: InAppWebView(
              initialUrlRequest: URLRequest(
                // url: WebUri("https://752.play.online.thopgames.in"),
                url: WebUri(gamesUrl),
                // url: WebUri('https://752.play.online.thopgames.in'),
                // url: WebUri('https://play526.atmequiz.com/start'),
                // url: WebUri('https://88.mark.qureka.com/intro/question'),
              ),
            ),
          ),
        );
      },
    );
  }
}
