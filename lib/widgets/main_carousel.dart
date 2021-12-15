import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/detail_screen.dart';
import '../widgets/carousel_with_indigator.dart';
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
              child: CachedNetworkImage(
                imageUrl: e.getImageUrl,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
