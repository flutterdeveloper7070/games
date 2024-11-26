import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo/pages/splash/splash_page.dart';

import 'app/constants/app_constant.dart';
import 'app/helper/scroll_helper.dart';

void main() {
  // WebViewPlatform.instance = WebWebViewPlatform();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: GetMaterialApp(
        title: AppStringConstant.appTitle,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(microseconds: 0),
        locale: Get.deviceLocale,
        scrollBehavior: ScrollHelper(),
        home: SplashPage(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: Center(
              child: child  ?? const SizedBox() ,
            ),
          );
        },
      ),
    );
  }
}
