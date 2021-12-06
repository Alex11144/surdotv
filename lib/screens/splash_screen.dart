import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:surdotv_app/screens/main_page.dart';
import 'package:surdotv_app/widgets/common_widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  Animation<Size> _animationSize;

  bool _animateStarted = false;

  double _initTop = 0;
  double _initLeft = 0;
  double _endTop = 50;

  @override
  void didChangeDependencies() {
    if (_initTop == 0) {
      _initTop = MediaQuery.of(context).size.height / 2 + 25;
      _initLeft = MediaQuery.of(context).size.width / 4;
    }
    super.didChangeDependencies();
  }

  void _animateLogo() {
    if (_animationController == null) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      );
    } else {
      _animationController.reset();
    }

    _animation = Tween<double>(
      begin: _initTop,
      end: _endTop,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        print(_animation.value);
        setState(() {});
        if (_animation.isCompleted) {
          //   Navigator.of(context).pushNamed(HomePageScreen.route_name);
        }
      });

    _animateStarted = true;
    _animationController.forward();
  }

  @override
  void dispose() {
    if (_animationController != null) _animationController.dispose();
    super.dispose();
  }

  double _size = 200;
  bool _large = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 200.0 : 100.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
        child: InkWell(
          child: AnimatedSize(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: SizedBox(
              width: _size,
              child: logoLSize,
            ),
          ),
          onTap: () {
            _animateLogo();
            _updateSize();
          },
        ),
        top: _animateStarted ? _animation.value : _initTop,
        left: _initLeft,
        // width: _initLeft * 2,
        // height: 50,
      ),
    ]));
  }
}
