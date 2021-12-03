import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/models/video_item.dart';

import '../widgets/common_widgets.dart';
import '../widgets/grid_item.dart';
import '../providers/videos.dart';

class SelectedCategoryScreen extends StatelessWidget {
  static const routeName = '/selected-category';
  // final List<String> _subCategories = [
  //   'Yerli filmlər',
  //   'Qısametrajlı filmlər',
  //   'Qısametrajlı filmlər'
  // ];
  final String categoryId;
  SelectedCategoryScreen(this.categoryId);

  @override
  Widget build(BuildContext context) {
    // final String categoryId =
    //     ModalRoute.of(context).settings.arguments as String;
final videos = Provider.of<Videos>(context, listen: false);
    print(videos.items.length);
    final _videos = videos.items.where((element) => element.categoryId == categoryId).toList() ;

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
            children: ['1','2']
                .map((e) => OutlinedButton(
                      onPressed: () {},
                      child: Text(e),
                      style: outlinedButtonStyle,
                    ))
                .toList(),
          ),
        ),
        GridView.builder(
          primary: false,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 5 / 4,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _videos.length,
          itemBuilder: ((ctx, i) => GridTile(
                child: GridItem(id: _videos[i].id, imgUrl: _videos[i].getImageUrl,title: _videos[i].videoHead),
              )),
        ),
      ],
    );
  }
}
