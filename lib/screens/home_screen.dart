import 'package:flutter/material.dart';

import '../widgets/home_page_block.dart';
import '../widgets/main_carousel.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MainCarousel(),
          HomePageBlock(
            leftHeader: 'Filmlər',
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
