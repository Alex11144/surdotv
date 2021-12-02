import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class MyVideoPlayer extends StatefulWidget {
  static const route_name = '/video-player';

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  var _maxHeight = 0.0;
  var _maxWidth = 0.0;
  var _isFullScreen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_maxHeight == 0.0) {
      _maxHeight = MediaQuery.of(context).size.height;
      _maxWidth = MediaQuery.of(context).size.width;
    }
    super.didChangeDependencies();
  }

  void _makeFullScreen() {
    _isFullScreen = true;
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _escapeFullScreen() {
    _isFullScreen = false;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _escapeFullScreen();
    super.dispose();
  }

  final String videoId = '401880318';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: _maxHeight,
          width: _maxWidth,
          child: VimeoPlayer(videoId: videoId),
        ),
        // Positioned(
        //   top: _maxHeight - 80,
        //   left: _maxWidth - 80,
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.fullscreen,
        //       size: 80,
        //     ),
        //     onPressed: () {
        //       if (!_isFullScreen) {
        //         print('object cliecked');
        //         setState(() {
        //           _makeFullScreen();
        //         });
        //       } else {
        //         print('d cliecked');
        //         _escapeFullScreen();
        //       }
        //     },
        //   ),
        // )
      ]),
    );
  }
}
