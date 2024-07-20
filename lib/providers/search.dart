import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/video_item.dart';

class SearchData with ChangeNotifier {
  List<VideoItem> _listData = [];
  List<String> _recommendList = [];

  List<VideoItem> get items => _listData;
  List<String> get recommendList => _recommendList;

  final apiKey = {
    'api_key': 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<void> getRecommends() async {
    final url = Uri.http(
      'api.surdotv.az',
      '/api/recommended-movies',
    );
    final resp = await http.get(url, headers: apiKey);

    if (resp.statusCode >= 400) return;

    final _listPhrases = (json.decode(resp.body)['items'] as List<dynamic>);

    if (_listPhrases != null)
      _listPhrases.forEach((e) {
        _recommendList.add(e as String);
      });

    notifyListeners();
  }

  Future<void> fetchData(String kwd) async {
    final url = Uri.http(
      'api.surdotv.az',
      '/api/search',
    );

    final resp = await http.post(
      url,
      headers: apiKey,
      body: {'keyword': kwd},
      encoding: Encoding.getByName("utf-8"),
    );

    if (resp.statusCode >= 400) return;

    _listData = (json.decode(resp.body)['videos'] as List<dynamic>).map((e) {
      return VideoItem(
        id: e['id'].toString(),
        subId: e['sub_id'],
        ordering: e['ordering'],
        videoHead: e['video_head'],
        videoUrl: e['video_url'],
        videoAbout: e['video_about'],
        url: e['url'],
        shortText: e['short_metn'],
        ogTitle: e['og_title'],
        ogKeywords: e['og_keywords'],
        ogDescription: e['og_description'],
        imageUrl: e['image'],
        viewed: e['baxilib'],
        len: e['zaman'],
        dt: e['tarix'],
        categoryId: '0',
      );
    }).toList();

    notifyListeners();
  }
}
