import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/providers/categories.dart';
import 'package:surdotv_app/providers/videos.dart';
import 'package:surdotv_app/screens/home_screen.dart';
import 'package:surdotv_app/screens/main_page.dart';
import 'package:surdotv_app/widgets/common_widgets.dart';
import '../helpers/custom_route.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  Animation<Size> _animationSize;

  bool _animateEnded = false;
  bool selected = true;
  double _initTop = 0;
  double _initLeft = 0;
  double _endTop = 50;
  double _width = 20;

  @override
  void didChangeDependencies() {
    if (_initTop == 0) {
      _initTop = MediaQuery.of(context).size.height / 2 + 25;
      _initLeft = MediaQuery.of(context).size.width / 4;
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
      _videoProvider.fetchAll().then((value) {});
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

  @override
  void dispose() {
    if (_animationController != null) _animationController.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 2500),
          opacity: selected ? 0.0 : 1.0,
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            width: selected ? 50.0 : 250.0,
            //  color: selected ? Colors.transparent : Colors.amber,
            curve: Curves.easeInToLinear,
            child: logoLSize,
            onEnd: () {
              // _animateEnded = true;

              Navigator.of(context)
                  .pushReplacementNamed(HomePageScreen.route_name);
            },
            // child: AnimatedOpacity(
            //   duration: const Duration(milliseconds: 300),
            //   opacity: _currentOpasity,
            //   onEnd: () {
            //     Navigator.of(context)
            //         .pushReplacementNamed(HomePageScreen.route_name);
            //     // Navigator.of(context).pushReplacement(
            //     //     CustomRoute(builder: (ctx) => HomePageScreen()));
            //   },
            //   child: AnimatedAlign(
            //     alignment: !selected ? Alignment.center : Alignment.topCenter,
            //     duration: const Duration(milliseconds: 300),
            //     curve: Curves.fastOutSlowIn,
            //     child: AnimatedContainer(
            //       height: !selected ? 200.0 : 100.0,
            //       width: !selected ? 200 : 100.0,
            //       duration: Duration(milliseconds: 300),
            //       curve: Curves.fastOutSlowIn,
            //       child: logoLSize,
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
