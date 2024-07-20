import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class About with ChangeNotifier {
  String content = '';
  String _content1 = '';
  String _content2 = '';
  bool _isLoaded = false;

  final apiKey = {
    'api_key': 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  };

  Future<void> fetchAll() async {
    final url = Uri.http('api.surdotv.az', '/api/about');

    try {
      final resp = await http.get(url, headers: apiKey);

      if (resp.statusCode >= 400) {
        content = '404';
        return;
      }
      content = json.decode(resp.body)['metn'];

      _content1 = content.substring(1, content.indexOf('Müxtəlif'));
      _content2 =
          content.substring(content.indexOf('Müxtəlif'), content.length);
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _isLoaded = true;
    }
  }

  bool get isLoaded => _isLoaded;

  String get content1 => _content1;
  String get content2 => _content2;

  Future<String> getContent() async {
    if (content == '') {
      fetchAll().then((_) {
        print(content1);
        return content1;
      }).onError((error, stackTrace) {
        return '';
      });
    } else
      return content1;
    return '';
  }
}
