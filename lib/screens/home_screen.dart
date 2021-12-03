import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/providers/categories.dart';
import 'package:surdotv_app/providers/videos.dart';

import '../widgets/home_page_block.dart';
import '../widgets/main_carousel.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isFetched = false;
  var _isLoading = false;
  var _isVideosLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isFetched) {
      try {
        setState(() {
          _isLoading = true;
        });
        
        Provider.of<Categories>(context).fetchAll().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
        Provider.of<Videos>(context).fetchAll().then((_) {
 setState(() {
            _isVideosLoaded = true;
          });
        });
        _isFetched = true;
      } catch (e) {}
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _categories = Provider.of<Categories>(context, listen: false);

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainCarousel(),
                HomePageBlock(
                    leftHeader: _categories.items[0].name,
                    leftIcon: Icons.videocam_outlined,
                    rightHeader: 'Bütün filmlər',
                    videoList: _categories.items[0].videoList),
                SizedBox(
                  height: 5,
                ),
                adsBlock(context),
                HomePageBlock(
                  leftHeader: _categories.items[1].name,
                  leftIcon: Icons.videogame_asset_outlined,
                  rightHeader: 'Bütün cizgi filmlər',
                  videoList: _categories.items[1].videoList,
                ),
              ],
            ),
          );
  }
}
