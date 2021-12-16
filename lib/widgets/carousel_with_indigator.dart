import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class CarouselWithIndigator extends StatefulWidget {
  List<dynamic> _itemList;
  double carouselHeigth;

  CarouselWithIndigator(this._itemList, this.carouselHeigth);

  @override
  _CarouselWithIndigatorState createState() => _CarouselWithIndigatorState();
}

class _CarouselWithIndigatorState extends State<CarouselWithIndigator> {
  var _itemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.carouselHeigth,
      //   color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: widget.carouselHeigth - 30,
                viewportFraction: 1,
                onPageChanged: (index, r) {
                  setState(() {
                    _itemIndex = index;
                  });
                }
                //   enlargeCenterPage: true,
                ),
            items: widget._itemList.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    //margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //  decoration: BoxDecoration(color: Colors.amber),
                    child: Center(
                      child: item,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          DotsIndicator(
            dotsCount: widget._itemList.length,
            position: _itemIndex.toDouble(),
            decorator: DotsDecorator(
              color: Colors.red[100], // Inactive color
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
            onTap: (index) {},
          ),
        ],
      ),
    );
  }
}
