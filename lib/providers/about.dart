import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class About with ChangeNotifier {
  String content = '';
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
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _isLoaded = true;
    }
  }

  bool get isLoaded => _isLoaded;
  String getContent() {
    if (content == '') {
      fetchAll().then((_) {
        return content;
      }).onError((error, stackTrace) =>  null);
    } else
      return content;
  }
}
