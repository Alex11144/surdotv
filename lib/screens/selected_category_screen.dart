import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/models/category_item.dart';
import 'package:surdotv_app/widgets/outline_button_widget.dart';

import '../models/video_item.dart';
import '../widgets/common_widgets.dart';
import '../widgets/grid_item.dart';
import '../providers/videos.dart';

class SelectedCategoryScreen extends StatefulWidget {
  static const routeName = '/selected-category';
  // final List<String> _subCategories = [
  //   'Yerli filmlər',
  //   'Qısametrajlı filmlər',
  //   'Qısametrajlı filmlər'
  // ];
  final String categoryId;
  final Widget catIcon;
  final String catTitle;
  SelectedCategoryScreen({
    this.categoryId,
    this.catTitle,
    this.catIcon,
  });

  @override
  State<SelectedCategoryScreen> createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends State<SelectedCategoryScreen> {
  ScrollController _scrollController;
  int pageCount = 1;
  bool isLoading = false;
  List<VideoItem> _videos = [];
  List<VideoItem> _allVideos = [];
  List<CategoryItem> _subcatList = [];
  double _height;

  bool _isInit = true;
  String _subCategoryId = '';
  bool _showUpButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController =
        new ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true)
          ..addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _reloadPage();
      _height = MediaQuery.of(context).size.height;
      _isInit = false;
    }
  }

  void _reloadPage() {
    final videos = Provider.of<Videos>(context, listen: false);
    pageCount = 1;

    

    if (_subCategoryId != '') {
      _allVideos = videos.items
          .where((element) => element.categoryId == _subCategoryId)
          .toList();
    }
    else
    {
      _allVideos = videos.items
        .where((element) => element.subCategoryId == widget.categoryId || element.categoryId == widget.categoryId)
        .toList();
    }
    _subcatList = videos.getSubCategeries(catId: widget.categoryId);
    print('init called');

    _videos =
        _allVideos.getRange(0, pageCount * min(10, _allVideos.length)).toList();
    if (_scrollController != null) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }
  }

  _scrollListener() {
    setState(() {
      _showUpButton = _scrollController.offset >
          _scrollController.position.maxScrollExtent * 0.2;
    });

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;

        if (isLoading) {
          pageCount = pageCount + 1;

          if (_videos.length < _allVideos.length) {
            _videos += _allVideos
                .getRange(
                    _videos.length,
                    _videos.length +
                        min(_allVideos.length - _videos.length, 10))
                .toList();
          } else {
            _showUpButton = true;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String categoryId =
    //     ModalRoute.of(context).settings.arguments as String;

    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              widget.catIcon,
              SizedBox(
                width: 5,
              ),
              Text(
                widget.catTitle,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _subcatList
                .map((e) => OutlineButtonWithAnimation(
                      txt: e.name,
                      func: () {
                        setState(() {
                          _subCategoryId = e.id;
                          _showUpButton = false;

                          _reloadPage();
                        });
                      },
                    ))
                .toList(),
          ),
        ),
        Container(
          height: _height - 260,
          child: OrientationBuilder(builder: (context, orientation) {
            final or = MediaQuery.of(context).orientation;
            return GridView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                gridDelegate: gridDelegate(or),
                itemCount: _videos.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: EdgeInsets.all(2),
                    child: GridItem(
                      id: _videos[i].id,
                      imgUrl: _videos[i].getImageUrl,
                      title: _videos[i].videoHead,
                    ),
                  );

                  // GridTile(
                  //   child: GridItem(
                  //     id: _videos[i].id,
                  //     imgUrl: _videos[i].getImageUrl,
                  //     title: _videos[i].videoHead,
                  //   ),
                  // );
                });
          }),
        ),
      ]),
      _showUpButton
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                child: Icon(
                  Icons.arrow_upward,
                ),
                backgroundColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                onPressed: () {
                  _scrollController.animateTo(0.0,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOut);
                },
              ),
            )
          : Container(),
    ]);
  }

  // Future<void> getNextPage(Videos videos, List<VideoItem> _videos) async {
  //     setState(() {
  //     videos.stepNextPartial();
  //      _videos = videos.itemsPartial;
  //   });
  // }
}
