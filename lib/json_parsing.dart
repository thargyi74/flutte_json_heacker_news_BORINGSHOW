import 'dart:convert' as json;

import 'dart:core';

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'json_parsing.g.dart';

/*
class Article {
  final String by;
  final String descendants;
  final int id;
  final int kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  const Article({
    this.id,
    this.title,
    this.by,
    this.score,
    this.time,
    this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Article(
        title: json['text'] ?? '[null]',
        url: json['url'] ?? '[null]',
        by: json['by'] ?? '[null]',
        time: json['time'] ?? 0,
        score: json['score'] ?? 0);
  }
}*/

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;

  @nullable
  String get by;

  @nullable
  int get descendants;

  int get id;

  @nullable
  BuiltList<int> get kids;

  @nullable
  int get score;

  @nullable
  int get time;

  @nullable
  String get title;

  @nullable
  String get type;

  @nullable
  String get url;

  @nullable
  bool get deleted;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get pool;

  @nullable
  BuiltList<int> get parts;

  Article._();

  factory Article([updates(ArticleBuilder b)]) = _$Article;
}

List<int> parseTopStories(String jsonString) {
  return [];
  /*final parsed = json.jsonDecode(jsonString);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;*/
}

Article parseArticle(String jsonString) {
  String parsed = json.jsonDecode(jsonString);
  Article article =
      standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}
