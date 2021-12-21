import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/widgets/common_widgets.dart';

import '../models/video_item.dart';
import './carousel_with_indigator.dart';
import './grid_item.dart';
import '../providers/menu_data.dart';

class HomePageBlock extends StatefulWidget {
  final String leftHeader;
  final String rightHeader;
  final Widget leftIcon;
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
  List<Widget> _itemList;
  double maxHeight = 420;

  @override
  void initState() {
    makeList();
    super.initState();
  }

  void makeList() {
    int _cnt = -1;
    _itemList = [0, 4, 8]
        .map((e) => Container(
              height: 350,
              width: double.infinity,
              child: GridView.builder(
                  gridDelegate: gridDelegate,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (ctx, i) {
                    return GridTile(
                      child: GridItem(
                        id: widget.videoList[e + i].id,
                        title: widget.videoList[e + i].videoHead,
                        imgUrl: widget.videoList[e + i].getImageUrl,
                      ),
                    );
                  }),
              alignment: Alignment.topCenter,
            ))
        .toList();
  }

  // void makeList2() {
  //   print('called makelist2 ${widget.catId}');
  //   _itemList = [0, 4, 8]
  //       .map((x) => Column(
  //             children: [
  //               ...[0, 2]
  //                   .map(
  //                     (y) => Row(
  //                       //mainAxisSize: MainAxisSize.min,
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: <Widget>[
  //                         ...[0, 1]
  //                             .map(
  //                               (z) => Expanded(
  //                                 child: GridItem(
  //                                   id: widget.videoList[x + y + z].id,
  //                                   title:
  //                                       widget.videoList[x + y + z].videoHead,
  //                                   imgUrl:
  //                                       widget.videoList[x + y + z].getImageUrl,
  //                                 ),
  //                               ),
  //                             )
  //                             .toList(),
  //                       ],
  //                     ),
  //                   )
  //                   .toList(),
  //             ],
  //           ))
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                widget.leftIcon,
                // Icon(
                //   widget.leftIcon,
                //   color: Colors.red,
                // ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.leftHeader,
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      final menuData = Provider.of<MenuData>(
                        context,
                        listen: false,
                      );
                      menuData.setMenuIndex(2);
                      print('object ${widget.catId}');
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
          CarouselWithIndigator(_itemList, 360),
        ],
      ),
    );
  }
}
