//import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/material.dart';
import 'package:surdotv_app/screens/detail_screen.dart';
import '../widgets/carousel_with_indigator.dart';
import '../widgets/common_widgets.dart';
import 'package:provider/provider.dart';
import '../providers/categories.dart';

class MainCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mainCarusel = Provider.of<Categories>(context).mainCarusel;

    List<Widget> _imgList = _mainCarusel
        .map((e) => InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(DetailScreen.routeName, arguments: {
                  'id': e.id,
                });
              },
              child: Image.network(
                e.getImageUrl,
                fit: BoxFit.fill,
              ),
            ))
        .toList();

    return Container(
      child: Column(
        children: [
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
