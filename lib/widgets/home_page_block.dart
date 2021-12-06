import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/models/video_item.dart';
import 'carousel_with_indigator.dart';

import './grid_item.dart';
import '../providers/menu_data.dart';
import '../screens/categories_screen.dart';

class HomePageBlock extends StatefulWidget {
  final String leftHeader;
  final String rightHeader;
  final IconData leftIcon;
  final List<VideoItem> videoList;
  final String catId;

  HomePageBlock(
      {this.leftHeader,
      this.leftIcon,
      this.rightHeader,
      this.videoList,
      this.catId});

  @override
  _HomePageBlockState createState() => _HomePageBlockState();
}

class _HomePageBlockState extends State<HomePageBlock> {
  final maxHeight = 400.0;
 

  List<Widget> _itemList;
  void makeList() {
    _itemList = [1, 2, 3]
        .map((e) => Container(
              width: double.infinity,
              child: GridView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4 / 5,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: 4,
                itemBuilder: ((ctx, i) => GridTile(
                      child: GridItem(title: 'a'),
                    )),
              ),
              alignment: Alignment.topCenter,
            ))
        .toList();
  }

  void makeList2() {
    _itemList = [0, 4, 8]
        .map((x) => Column(
              children: [
                ...[0, 2]
                    .map(
                      (y) => Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: <Widget>[
                          ...[0, 1]
                              .map(
                                (z) => Expanded(
                                  child: GridItem(
                                      id: widget.videoList[x + y + z].id,
                                      title:
                                          widget.videoList[x + y + z].videoHead,
                                      imgUrl: widget
                                          .videoList[x + y + z].getImageUrl),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    )
                    .toList(),
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    makeList2();
    return Container(
      height: maxHeight,
      //  color: Colors.red[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  widget.leftIcon,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(widget.leftHeader),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      final menuData = Provider.of<MenuData>(
                        context,
                        listen: false,
                      );
                      menuData.setMenuIndex(2);
                      menuData.setCategoryId(widget.catId);
                    });
                  },
                  child: Text(
                    widget.rightHeader,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          CarouselWithIndigator(_itemList, maxHeight * 0.8),
        ],
      ),
    );
  }
}
