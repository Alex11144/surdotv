import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/categories.dart';
import '../providers/videos.dart';
import '../screens/main_page.dart';
import '../widgets/common_widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool selected = true;
  double _initTop = 0;

  @override
  void didChangeDependencies() {
    if (_initTop == 0) {
      _initTop = MediaQuery.of(context).size.height / 2 + 25;
    }
    print('splash start ' + DateTime.now().toString());
    final _catProvider = Provider.of<Categories>(
      context,
      listen: false,
    );

    if (!_catProvider.isLoaded) {
      _catProvider.fetchAll().then((value) {
        //  Navigator.of(context).pushReplacementNamed(HomePageScreen.route_name);

        setState(() {
          _currentOpasity = 0;
          selected = !selected;
          print('splash end ' + DateTime.now().toString());
        });
      });
    }

    final _videoProvider = Provider.of<Videos>(
      context,
      listen: false,
    );

    if (!_videoProvider.isLoaded) {
      print("call from splashscreen" + DateTime.now().toString());
      _videoProvider.fetchAll();
    }

    super.didChangeDependencies();
  }

  // void _animateLogo() {
  //   if (_animationController == null) {
  //     _animationController = AnimationController(
  //       vsync: this,
  //       duration: Duration(milliseconds: 500),
  //     );
  //   } else {
  //     _animationController.reset();
  //   }

  //   _animation = Tween<double>(
  //     begin: _initTop,
  //     end: _endTop,
  //   ).animate(CurvedAnimation(
  //       parent: _animationController, curve: Curves.fastOutSlowIn))
  //     ..addListener(() {

  //       setState(() {});
  //       if (_animation.isCompleted) {
  //         Navigator.of(context).pushReplacementNamed(HomePageScreen.route_name);
  //       }
  //     });

  //   _animateStarted = true;
  //   _animationController.forward();
  // }

  double _sizeH = 50;
  double _sizeW = 100;
  bool _large = false;

  void _updateSize() {
    setState(() {
      _sizeH = _large ? 50.0 : 25.0;
      _sizeW = _large ? 100.0 : 50.0;
      _large = !_large;
    });
  }

  double _currentOpasity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   toolbarHeight: 0,
      //   elevation: 0,
      //   systemOverlayStyle:
      //       SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      // ),
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 1000),
          opacity: selected ? 1.0 : 0.0,
          child: logoMSize,
          onEnd: () {
            Navigator.of(context)
                .pushReplacementNamed(HomePageScreen.route_name);
          },
        ),
      ),
    );
  }
}
