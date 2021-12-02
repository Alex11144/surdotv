import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:surdotv_app/models/video_item.dart';
import 'dart:convert';

import '../models/category_item.dart';

class Categories with ChangeNotifier {
  List<CategoryItem> _items;

  void addItem(CategoryItem catItem) {
    _items.add(catItem);
    notifyListeners();
  }

  void clearItems() {
    _items = null;
  }

  List<CategoryItem> get Items => _items;

  Future<void> FetchAll() async {
    final url = 'http://api.surdotv.az/api/index';
    try {
      final resp = await http.get(url, headers: {
        'api_key':
            'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
      });

      if (resp.statusCode >= 400) {
        return;
      } else {}

      final extactedData =
          json.decode(resp.body)['movies'] as Map<String, dynamic>;

      List<CategoryItem> loadedItems = [];

      if (extactedData == null) {
        return;
      }

      loadedItems.add(
        CategoryItem(
          id: extactedData['id'].toString(),
          name: extactedData['name'],
          url: extactedData['url'],
          subId: extactedData['sub_id'],
          videoList: (extactedData['video_list'] as List<dynamic>)
              .map(
                (e) => VideoItem(
                  id: e['id'],
                  subId: e['sub_id'],
                  ordering: e['ordering'],
                  videoHead: e['video_head'],
                  videoUrl: e['video_url'],
                  videoAbout: e['video_about'],
                  url: e['url'],
                  shortText: e['short+metn'],
                  ogTitle: e['og_title'],
                  ogKeywords: e['og_keywords'],
                  ogDescription: e['og_description'],
                  imageUrl: e['image'],
                  viewed: e['baxilib'],
                  len: e['zaman'],
                  dt: e['tarix'],
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      print('error : ${e.toString()}');
    }
    notifyListeners();
  }
}
