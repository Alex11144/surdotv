import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/video_item.dart';

class Videos with ChangeNotifier {
  List<VideoItem> _items = [];
  bool _isLoaded = false;

  void addItem(VideoItem videoItem) {
    final _idx = _items.indexWhere((element) => element.id == videoItem.id);
    if (_idx >= 0) {
      _items.add(videoItem);
      print('video added');
      notifyListeners();
    } else
      print('already exist');
  }

  void clearItems() {
    _items = null;
  }

  List<VideoItem> get items => _items;
  bool get isLoaded => _isLoaded;

  final apiKey = {
    'api_key': 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  };

  Future<void> fetchAll() async {
    final url = Uri.http('api.surdotv.az', '/api/sections');

    await http.get(url, headers: apiKey).then((resp) {
      final catList =
          json.decode(resp.body)['category']['sub_items'] as List<dynamic>;

      if (catList != null) {
        catList.forEach((cat) {
          final url = Uri.http('api.surdotv.az', '/api/sections/${cat['id']}');

          http.get(url, headers: apiKey).then((respVideo) {
            final videoList =
                json.decode(respVideo.body)['video_list'] as List<dynamic>;

            videoList.forEach((e) {
              final _newVideoItem = VideoItem(
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
                categoryId: cat['id'].toString(),
              );
              _items.add(_newVideoItem);
            });
            print('how manu ${_items.length}');
            _isLoaded = true;
            notifyListeners();
          });
        });
      }

      print(DateTime.now());
    });
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
}
