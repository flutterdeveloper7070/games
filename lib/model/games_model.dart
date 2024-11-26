// To parse this JSON data, do
//
//     final gamesModel = gamesModelFromJson(jsonString);

import 'dart:convert';

GamesModel gamesModelFromJson(String str) => GamesModel.fromJson(json.decode(str));

String gamesModelToJson(GamesModel data) => json.encode(data.toJson());

class GamesModel {
  List<CategoriesList>? categoriesList;

  GamesModel({
    this.categoriesList,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) => GamesModel(
    categoriesList: json["categories_list"] == null ? [] : List<CategoriesList>.from(json["categories_list"]!.map((x) => CategoriesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories_list": categoriesList == null ? [] : List<dynamic>.from(categoriesList!.map((x) => x.toJson())),
  };
}

class CategoriesList {
  int? id;
  String? catImgUrl;
  String? categorieName;
  String? catGamesUrl;
  List<GamesList>? gamesList;

  CategoriesList({
    this.id,
    this.catImgUrl,
    this.categorieName,
    this.catGamesUrl,
    this.gamesList,
  });

  factory CategoriesList.fromJson(Map<String, dynamic> json) => CategoriesList(
    id: json["id"],
    catImgUrl: json["cat_img_url"],
    categorieName: json["categorie_name"],
    catGamesUrl: json["cat_games_url"],
    gamesList: json["games_list"] == null ? [] : List<GamesList>.from(json["games_list"]!.map((x) => GamesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_img_url": catImgUrl,
    "categorie_name": categorieName,
    "cat_games_url": catGamesUrl,
    "games_list": gamesList == null ? [] : List<dynamic>.from(gamesList!.map((x) => x.toJson())),
  };
}

class GamesList {
  int? id;
  String? gameName;
  String? imageUrl;
  String? gameUrl;

  GamesList({
    this.id,
    this.gameName,
    this.imageUrl,
    this.gameUrl,
  });

  factory GamesList.fromJson(Map<String, dynamic> json) => GamesList(
    id: json["id"],
    gameName: json["game_name"],
    imageUrl: json["image_url"],
    gameUrl: json["game_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game_name": gameName,
    "image_url": imageUrl,
    "game_url": gameUrl,
  };
}
