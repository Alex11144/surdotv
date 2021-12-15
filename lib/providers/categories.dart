import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/video_item.dart';
import '../models/category_item.dart';

class Categories with ChangeNotifier {
  List<CategoryItem> _items = [];
  List<VideoItem> _mainCarusel;

  bool _isLoaded = false;
  BuildContext ctx;

  Categories(this.ctx);

  void addItem(CategoryItem catItem) {
    _items.add(catItem);
    notifyListeners();
  }

  void clearItems() {
    _items = null;
  }

  List<CategoryItem> get items => _items;
  bool get isLoaded => _isLoaded;
  List<VideoItem> get mainCarusel => _mainCarusel;

  Future<void> fetchAll() async {
    final url = Uri.http('api.surdotv.az', '/api/index');
    final apiKey = {
      'api_key':
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    };

    try {

      final resp = await http.get(url, headers: apiKey);

      if (resp.statusCode >= 400) {
        _isLoaded = true;
        return;
      } else {}

      final extactedData = json.decode(resp.body) as Map<String, dynamic>;

      List<CategoryItem> loadedItems = [];

      if (extactedData == null) {
        _isLoaded = true;
        return;
      }

      var categotyData = extactedData['movies'];

      loadedItems.add(json2CategoryItem(categotyData));
      categotyData = extactedData['cartoons'];
      loadedItems.add(json2CategoryItem(categotyData));

      _mainCarusel = (extactedData['sliderItems'] as List<dynamic>).map((e) {
        final _newItem = VideoItem(
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
        
        );


        return _newItem;
      }).toList();

 

      _items = loadedItems;
      _isLoaded = true;
    } catch (e) {
      _isLoaded = true;
      print('error : ${e.toString()}');
    }
    notifyListeners();
  }

  CategoryItem json2CategoryItem(dynamic obj) {
    return CategoryItem(
      id: obj['id'].toString(),
      name: obj['name'],
      url: obj['url'],
      subId: obj['sub_id'],
      videoList: (obj['video_list'] as List<dynamic>).map((e) {
        final _newItem = VideoItem(
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
          
        );
  
        return _newItem;
      }).toList(),
    );
  }
}
