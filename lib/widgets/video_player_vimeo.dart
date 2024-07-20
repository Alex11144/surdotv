import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/vimeo_api.dart';

///vimeo player for Flutter apps
///Flutter plugin based on the [webview_flutter] plugin
///[videoId] is the only required field to use this plugin
///
///
///
///
class MyVimeoPlayer extends StatefulWidget {
  final String videoId;

  MyVimeoPlayer(
    this.videoId,
  );

  @override
  State<MyVimeoPlayer> createState() => _MyVimeoPlayerState();
}

class _MyVimeoPlayerState extends State<MyVimeoPlayer> {
  bool _isLoaded = false;

  String _videoPage = '';

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      final _vimeoApi = Provider.of<VimeoApi>(context);
      //final _vimeoApi = VimeoApi(videoId)..login();

      _vimeoApi.getVideoPage(widget.videoId).then((_) {
        setState(() {
          _videoPage = _vimeoApi.videoPage!;
          _isLoaded = true;
          print(_videoPage);
        });
      });
    }
    return !_isLoaded
        ? Center(
            child: CircularProgressIndicator(),
          )
        : WebView(
            initialUrl: _videoHtml(_videoPage),
            javascriptMode: JavascriptMode.unrestricted,
          );
  }

  ///web page containing iframe of the vimeo video
  ///
  ///
  ///
  ///
  String _videoHtml(String iframe) {
    final html = '''
            <html>
              <head>
                <style>
                  body {
                   background-color: lightgray;
                   margin: 0px;
                   }
                   iframe {
                            display: block;      
                            background: #000;
                            border: none;        
                            height: 100vh;        
                            width: 100vw;
                        }
                </style>
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
             </head>
             <body>
                $iframe
             </body>
            </html>
            ''';
    print(iframe);
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(html));
    return 'data:text/html;base64,$contentBase64';
  }
}
