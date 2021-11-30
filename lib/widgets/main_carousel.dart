//import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/material.dart';
import '../widgets/carousel_with_indigator.dart';
import '../widgets/common_widgets.dart';

class MainCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _imgList = [
      'https://surdotv.az/uploads/bir-qalanin-sirri--196_51.jpg',
      'https://surdotv.az/uploads/min-bir-ilme---197_29.jpg',
      'https://surdotv.az/uploads/asif--vasif--agasif--193_51.jpg',
    ]
        .map((e) => Image.network(
              e,
              fit: BoxFit.fill,
            ))
        .toList();

    return Container(

      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            elevation: 0,
            title: logoMSize,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          Container(
            height: 200,
            child: CarouselWithIndigator(_imgList, 200.0),
          ),
        ],
      ),
       decoration: BoxDecoration(
               
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset.zero,
                  ),
              ],
              color: Theme.of(context).colorScheme.primary,
            ),
    );
  }
}
