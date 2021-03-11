import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/models/search_options.dart';

Dio dio = Dio(BaseOptions(
  baseUrl: 'https://newsapi.org/v2/',
  headers: {'X-Api-Key': 'd0322a583e7e46ed96ea4665b22629d8'},
));

topHeadlines(SearchOptions _searchOptions) async {
  try {
    final response = await dio.get('top-headlines', queryParameters: {
      'country' : 'in',
      ...(_searchOptions != null ? _searchOptions.toJson() : {}),
    });

    print(response.data['articles']);
    List<News> list=[];
    response.data['articles'].forEach((json)=>list.add(News.fromJson(json)));
    return list;
  } catch (e) {
    print(e);
  }
}
