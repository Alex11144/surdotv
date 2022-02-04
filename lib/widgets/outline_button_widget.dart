import 'package:flutter/material.dart';
import 'package:surdotv_app/widgets/common_widgets.dart';

class OutlineButtonWithAnimation extends StatefulWidget {
  final VoidCallback func;
  final String txt;
  OutlineButtonWithAnimation({this.txt, this.func});

  @override
  _OutlineButtonWithAnimationState createState() =>
      _OutlineButtonWithAnimationState();
}

class _OutlineButtonWithAnimationState
    extends State<OutlineButtonWithAnimation> {
  var _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _isPressed = !_isPressed;
        });

        Future.delayed(Duration(milliseconds: 200)).then((value) {
          widget.func();
          setState(() {
            _isPressed = !_isPressed;
          });
        });
      },
      child: Text(
        widget.txt,
        style: Theme.of(context)
            .textTheme
            .caption
            .copyWith(color: _isPressed ? Colors.white : Colors.black),
      ),
      style: outlinedButtonStyle(context, _isPressed),
    );
  }
}
