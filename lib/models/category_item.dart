import 'package:surdotv_app/models/video_item.dart';

class CategoryItem {
  String id;
  String name;
  String url;
  int active;
  int ordering;
  String subId;
  String txt;
  String image;
  String ogTitle;
  String ogKeywords;
  String ogDescription;
  List<VideoItem> videoList;
  String parentCategoryId;

  CategoryItem({
    this.id,
    this.name,
    this.url,
    this.active,
    this.ordering,
    this.subId,
    this.txt,
    this.image,
    this.ogTitle,
    this.ogKeywords,
    this.ogDescription,
    this.videoList,
    this.parentCategoryId,
  });

  void setVideoList(List<VideoItem> itemList) {
    videoList = itemList;
  }
}
  // "id": 8,
  //       "name": "Filmlər",
  //       "url": "filmler/",
  //       "active": "1",
  //       "ordering": "7",
  //       "sub_id": "3",
  //       "metn": "",
  //       "image": "",
  //       "og_title": "Filmlər - SurdoTV.az",
  //       "og_keywords": "surdotv, surdo tv filmlər, surdo tv filmlər, surdo tv filmlər",
  //       "og_description": "SurdoTV -də yayımlanan filmlər",
  //       "video_list": [