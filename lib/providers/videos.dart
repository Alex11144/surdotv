import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:surdotv_app/models/category_item.dart';
import 'dart:convert';

import '../models/video_item.dart';

class Videos with ChangeNotifier {
  List<VideoItem> _items = [];
  bool _isLoaded = false;
  bool _isLoading = false;

  var _step = 10;
  List<VideoItem> _itemsPartial = [];
  List<VideoItem> get itemsPartial => _itemsPartial;

  void stepNextPartial() {
    _itemsPartial = (_items.getRange(0, _step).toList());
    _step += 10;
  }

  void addItem(VideoItem videoItem) {
    final _idx = _items.indexWhere((element) => element.id == videoItem.id);
    if (_idx >= 0) {
      _items.add(videoItem);

      notifyListeners();
    }
  }

  void clearItems() {
    _items = null;
  }

  List<VideoItem> get items => _items;
  bool get isLoaded => _isLoaded;
  bool get isLoading => _isLoading;

  final apiKey = {
    'api_key': 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  };

  Future<void> fetchAll() async {
    final url = Uri.http('api.surdotv.az', '/api/sections');

    http.get(url, headers: apiKey).then((resp) {
      final catList =
          json.decode(resp.body)['category']['sub_items'] as List<dynamic>;
      int _idxCat = 0;
      if (catList != null) {
        catList.forEach((cat) {
          final url = Uri.http('api.surdotv.az', '/api/sections/${cat['id']}');

          http.get(url, headers: apiKey).then((respVideo) {
            final videoList =
                json.decode(respVideo.body)['video_list'] as List<dynamic>;
            _idxCat++;
            videoList.forEach((e) {
              final _newVideoItem = VideoItem(
                id: e['id'].toString(),
                subId: e['category']['id'].toString(),//e['sub_id'],
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
                categoryId: e['category']['id'].toString(),
                subCategoryId: e['category']['sub_id'].toString(),
                subCategoryName: e['category']['name'],
              );
              _items.add(_newVideoItem);
              print(_newVideoItem);
            });

            if (catList.length == _idxCat) {
              _isLoaded = true;

              print('how many loaded = ${_items.length}');
              notifyListeners();
            }
          });
        });
      }
    });
    _isLoading = true;
    print('how many loaded  ${_items.length}');
  }

  List<VideoItem> similarItems(int cnt, String id) {
    List<VideoItem> _ret = [];
    final index =
        _items.indexOf(_items.firstWhere((element) => element.id == id));

    for (var i = 0; i < cnt; i++) {
      if ((i + index) < _items.length) {
        _ret.add(_items[i + index]);
      } else {
        _ret.add(_items[_items.length - i - 1]);
      }
    }
    return _ret;
  }

  List<CategoryItem> getSubCategeries({String catId}) {
    List<CategoryItem> _ret = [];

    _items.where((element) => element.subCategoryId == catId).forEach((e) {
      final _catItem = CategoryItem(
        id: e.categoryId,
        parentCategoryId: e.subCategoryId,
        name: e.subCategoryName,
      );

      if (_ret.indexWhere((e) => e.id == _catItem.id) < 0) _ret.add(_catItem);
    });

    return _ret;
  }
}
