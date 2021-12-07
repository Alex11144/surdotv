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
          Navigator.of(context).pushNamed(HomePageScreen.route_name);
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

  bool selected = false;
  double _currentOpasity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _updateSize();
          setState(() {
            selected = !selected;
            _currentOpasity = 0;
          });
        },
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _currentOpasity,
            onEnd: () {
              Navigator.of(context).pushNamed(HomePageScreen.route_name);
            },
            child: AnimatedAlign(
              alignment: !selected ? Alignment.center : Alignment.topCenter,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: AnimatedContainer(
                height: !selected ? 200.0 : 100.0,
                width: !selected ? 200 : 100.0,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: logoLSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
