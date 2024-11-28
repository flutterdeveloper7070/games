import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:web_demo/app/ui/app_image_assets.dart';
import 'package:web_demo/controller/splash_controller.dart';
import 'package:web_demo/pages/ads/ads_page.dart';
import 'package:web_demo/pages/games/games_page.dart';
import 'package:web_demo/routes/route_helper.dart';
import 'dart:html';

import '../../model/games_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GamesModel? gamesModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final String response = await rootBundle.loadString('assets/data/games.json');
    gamesModel = gamesModelFromJson(response);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          body: gamesModel != null ? bodyView() : const SizedBox(),
          appBar: AppBar(
            title: const Text("Games"),
          ),
          // body: InAppWebView(
          //   initialUrlRequest: URLRequest(url: WebUri('https://play526.atmequiz.com/start')),
          // ),
        );
      },
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10, bottom: 50),
      child: Column(
        children: [
          updatedNewsView(),
          const SizedBox(height: 25),
          Container(
            height: 70,
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.5),
            child: const Text("Ads Space..."),
          ),
          const SizedBox(height: 20),
          gamesView(),
        ],
      ),
    );
  }

  Widget gamesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                "View All",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.symmetric(horizontal: 21.0),
          shrinkWrap: true,
          childAspectRatio: 1.25,
          crossAxisSpacing: 13,
          mainAxisSpacing: 13,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            4,
            (index) {
              CategoriesList categoriesList = gamesModel!.categoriesList![index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: AppImageAsset(
                  image: categoriesList.catImgUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 250,
          alignment: Alignment.center,
          color: Colors.grey.withOpacity(0.5),
          child: const Text("Ads Space..."),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            CategoriesList categoriesList = gamesModel!.categoriesList![index];
            return secondGamesView(categoriesList: categoriesList);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
          itemCount: gamesModel?.categoriesList?.length ?? 0,
        )
      ],
    );
  }

  Widget secondGamesView({CategoriesList? categoriesList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              Text(
                categoriesList?.categorieName ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Text(
                "View All",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 140,
          child: GridView.count(
            crossAxisCount: 1,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              categoriesList?.gamesList?.length ?? 0,
              (index) {
                GamesList gamesList = categoriesList!.gamesList![index];
                return GestureDetector(
                  onTap: () async {
                    window.localStorage['gamesUrl'] = gamesList.gameUrl ?? '';
                    context.go(RouteHelper.games);
                    Future.delayed(
                      const Duration(milliseconds: 200),
                      () => window.location.href = 'https://752.play.online.thopgames.in',
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return GamesPage(gamesUrl: gamesList.gameUrl ?? '');
                    //     },
                    //   ),
                    // );

                    // Get.to(AdsPage());
                    // var result = await Navigator.push(context, MaterialPageRoute(
                    //    builder: (context) {
                    //      return const AdsPage();
                    //    },
                    //  ));
                    // if(result != null && result == true){
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) {
                    //         return GamesPage(gamesUrl: gamesList.gameUrl ?? '');
                    //       },
                    //     ),
                    //   );
                    // }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: AppImageAsset(
                      image: gamesList.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget updatedNewsView() {
    return CarouselSlider(
      items: List.generate(
        5,
        (index) => Container(
          decoration: BoxDecoration(
            color: CupertinoColors.activeBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          // child: AppText(
          //   text: "Updated News $index",
          //   fontSize: 18,
          //   fontColor: AppColorConstants.appWhite,
          // ),
        ),
      ),
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
        initialPage: 0,
      ),
    );
  }
}
