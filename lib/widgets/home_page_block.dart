import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'carousel_with_indigator.dart';

import './grid_item.dart';

class HomePageBlock extends StatefulWidget {
  final String leftHeader;
  final String rightHeader;
  final IconData leftIcon;

  HomePageBlock({this.leftHeader, this.leftIcon, this.rightHeader});

  @override
  _HomePageBlockState createState() => _HomePageBlockState();
}

class _HomePageBlockState extends State<HomePageBlock> {
  final maxHeight = 400.0;
  var _selectedPageIndex = 1.0;

  List<Widget> _itemList;
  List<int> _gridItems = [0, 1, 2, 3];

  @override
  void initState() {
    // makeList();
    print('make list called ');
    super.initState();
  }

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
                      child: GridItem('a'),
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
                                    (x + y + z).toString(),
                                  ),
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
                  onPressed: () {},
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
