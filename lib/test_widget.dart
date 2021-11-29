import 'package:flutter/material.dart';

class TestWg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      color: Colors.grey[800],
      child: Center(
        child: Ink.image(
          image: const AssetImage('cat.jpeg'),
          fit: BoxFit.cover,
          width: 300.0,
          height: 200.0,
          child: InkWell(
              onTap: () {/* ... */},
              child: const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'KITTEN',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ),
      ),
    ));
  }
}
