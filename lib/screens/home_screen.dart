import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/providers/categories.dart';

import '../widgets/home_page_block.dart';
import '../widgets/main_carousel.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _catFuture;
  var _isFetched = false;
  Future _obtainCatFuture() {
    return Provider.of<Categories>(context, listen: false).FetchAll();
  }

  @override
  void initState() {
    _catFuture = _obtainCatFuture().then((value) => () {
          setState(() {
            _isFetched = true;
          });
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _categories = Provider.of<Categories>(context);

    // if (!_isFetched) {
    //   _categories.FetchAll().then((value) => () {
    //         setState(() {
    //           _isFetched = true;
    //           print('object fetched');
    //         });
    //       });
    // }

    return !_isFetched
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainCarousel(),
                HomePageBlock(
                  leftHeader: _categories.Items[0].name,
                  leftIcon: Icons.videocam_outlined,
                  rightHeader: 'Bütün filmlər',
                ),
                SizedBox(
                  height: 5,
                ),
                adsBlock(context),
                HomePageBlock(
                  leftHeader: 'Cizgi Filmlər',
                  leftIcon: Icons.videogame_asset_outlined,
                  rightHeader: 'Bütün cizgi filmlər',
                ),
              ],
            ),
          );
  }
}
