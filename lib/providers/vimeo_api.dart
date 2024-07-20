import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VimeoApi with ChangeNotifier {
  String? _videoPage;

  String? get videoPage => _videoPage;

  Future<String> getVideoPage(String videoId) async {
    Uri url = Uri.parse('https://api.vimeo.com/videos/$videoId');
    Map<String, String> params = {
      'Authorization':
          'Basic YWMzZjkxMDQ1ZTg2ODhkMDUwMGZhYjU3ZjI4ODhmOWNjNWEwOTQ4YjpQRzdCZC9NY0E2NzR5SEJURlA0WHBncXVJY1pNQ21FcWZnSmQ2ODJXbWh5R2JpV3gxbWovbzg0bG91RU5XWmUrWlRnSUZqWGJxZXo4M2wzTGRnT3dUejJIWHVQMWJ0aFpvRmZZZ3VXeE9JQXNUVEwwbnVaM21qUnJTb3lFQndPVQ==',
    };

    final resp = await http.get(url, headers: params);
    print(resp.body);
    if (resp.statusCode >= 400) {
      return "";

      ///
    } else {
      final _jsonData = json.decode(resp.body);
      final _html = _jsonData['embed']['html'];
      _videoPage = _html;
      notifyListeners();
      return _videoPage??'';
    }
  }
}
