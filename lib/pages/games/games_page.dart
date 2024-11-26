import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

class GamesPage extends StatefulWidget {
  final String gamesUrl;

  const GamesPage({super.key, this.gamesUrl = ''});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Scaffold(
              body: InAppWebView(

                initialUrlRequest: URLRequest(
                  url: WebUri(widget.gamesUrl),
                  // url: WebUri('https://752.play.online.thopgames.in'),
                  // url: WebUri('https://play526.atmequiz.com/start'),
                  // url: WebUri('https://88.mark.qureka.com/intro/question'),

                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      userAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/537.36"
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
