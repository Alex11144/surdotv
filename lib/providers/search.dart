import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:surdotv_app/models/video_item.dart';

class SearchData with ChangeNotifier {
  List<VideoItem> _listData = [];

  List<VideoItem> get items => _listData;

  Future<void> fetchData(String kwd) async {
    final url = Uri.http('api.surdotv.az', '/api/search',);
    final apiKey = {
      'api_key':'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
      'Content-Type': 'application/x-www-form-urlencoded'
    };


 
    final resp = await http.post(
      url,
      headers: apiKey,
      body: {'keyword': kwd},      
      encoding: Encoding.getByName("utf-8"),
    );

    if (resp.statusCode >= 400) return;
    
   print((json.decode(resp.body)));
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
