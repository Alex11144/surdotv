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

  double _maxHeight = 420.0;
  double _carueselHeight = 360.0;
  double _textScaleFactor = 1.0;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      makeList();
      final _size = MediaQuery.of(context);

      if (_size.size.width > 600) {
        _carueselHeight = 720;
        _maxHeight = 840;
        _textScaleFactor = 1.15;
      } else {}
    });

    super.initState();
  }

  void makeList() {
    _itemList = [0, 4, 8]
        .map((e) => Container(
              //  height: 700,
              width: double.infinity,
              child: OrientationBuilder(builder: (context, orientation) {
                final or = MediaQuery.of(context).orientation;
                return GridView.builder(
                    gridDelegate: gridDelegate(or),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (ctx, i) {
                      return GridTile(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          child: GridItem(
                            id: widget.videoList[e + i].id,
                            title: widget.videoList[e + i].videoHead,
                            imgUrl: widget.videoList[e + i].getImageUrl,
                          ),
                        ),
                      );
                    });
              }),
              alignment: Alignment.topCenter,
            ))
        .toList();
    setState(() {});
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
      height: _maxHeight,
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

                      menuData.setCategoryId(widget.catId);

                      print('submenu ${menuData.selectedCategoryId}');
                    });
                  },
                  child: Text(
                    widget.rightHeader,
                    textScaleFactor: _textScaleFactor,
                    style: Theme.of(context).textTheme.caption.copyWith(
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
          _itemList == null
              ? Center(child: CircularProgressIndicator())
              : CarouselWithIndigator(_itemList, _carueselHeight),
        ],
      ),
    );
  }
}
