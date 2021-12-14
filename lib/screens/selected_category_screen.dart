import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/models/video_item.dart';

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
  SelectedCategoryScreen(this.categoryId);

  @override
  State<SelectedCategoryScreen> createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends State<SelectedCategoryScreen> {
  ScrollController _scrollController;
  int pageCount = 1;
  bool isLoading = false;
  List<VideoItem> _videos = [];
  List<VideoItem> _allVideos = [];

  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final videos = Provider.of<Videos>(context, listen: false);
      _allVideos = videos.items
          .where((element) => element.categoryId == widget.categoryId)
          .toList();
      _videos = _allVideos.getRange(0, pageCount *10).toList();  
      print('loaded first 10');  
      _isInit  = false;
    }
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("comes to bottom $isLoading");
        isLoading = true;

        if (isLoading) {
          print("RUNNING LOAD MORE");

          pageCount = pageCount + 1;
          print("pagecount $pageCount");
           _allVideos.getRange(_videos.length,_videos.length+ 10).toList().map((e) {
             _videos.add(e);
           });    
        }
      });
    }
  }

   

  @override
  Widget build(BuildContext context) {
    // final String categoryId =
    //     ModalRoute.of(context).settings.arguments as String;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              vCamera,
              SizedBox(
                width: 5,
              ),
              Text(
                'Filmlər',
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
            children: ['1', '2']
                .map((e) => OutlinedButton(
                      onPressed: () {},
                      child: Text(e),
                      style: outlinedButtonStyle,
                    ))
                .toList(),
          ),
        ),
        GridView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,

            //   physics: const AlwaysScrollableScrollPhysics(),
          //  primary: false,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5 / 4,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _videos.length +1 ,
            itemBuilder: (ctx, i) {
               if (i == _videos.length) {
                 return true
                        ? Center(child: CircularProgressIndicator())
                        : Container();
               }
                return GridTile(
                  child: GridItem(
                      id: _videos[i].id,
                      imgUrl: _videos[i].getImageUrl,
                      title: _videos[i].videoHead),
                );
             
            }),
      ],
    );
  }

  // Future<void> getNextPage(Videos videos, List<VideoItem> _videos) async {
  //     setState(() {
  //     videos.stepNextPartial();
  //      _videos = videos.itemsPartial;
  //   });
  // }
}
