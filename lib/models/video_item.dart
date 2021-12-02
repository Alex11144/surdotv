class VideoItem {
  int id;
  String subId;
  String ordering;
  String videoHead;
  String videoUrl;
  String videoAbout;
  String active;
  String url;
  String shortText;
  String serialId;
  String ogTitle;
  String ogKeywords;
  String ogDescription;
  String imageUrl;
  String viewed;
  String len;
  String dt;

  VideoItem(
      {this.id,
      this.subId,
      this.ordering,
      this.videoHead,
      this.videoUrl,
      this.videoAbout,
      this.active,
      this.url,
      this.shortText,
      this.serialId,
      this.ogTitle,
      this.ogKeywords,
      this.ogDescription,
      this.imageUrl,
      this.viewed,
      this.len,
      this.dt});

  String get getImageUrl => 'https://surdotv.az/uploads/$imageUrl';
  String get getVideoUrl => 'https://vimeo.com/$videoUrl';
}


// {
//                 "id": 25,
//                 "sub_id": "23",
//                 "ordering": "26",
//                 "video_head": "Möcüzələr adası ",
//                 "video_url": "398921981",
//                 "video_about": "&lt;p&gt;&lt;span style=&quot;color: #222222; font-family: sans-serif; font-size: 14px; background-color: #ffffff;&quot;&gt;Kinopovest&amp;nbsp;&lt;/span&gt;Xəzər dənizində&lt;span style=&quot;color: #222222; font-family: sans-serif; font-size: 14px; background-color: #ffffff;&quot;&gt;&amp;nbsp;salınmış&amp;nbsp;&lt;/span&gt;Neft Daşlarının&lt;span style=&quot;color: #222222; font-family: sans-serif; font-size: 14px; background-color: #ffffff;&quot;&gt;&amp;nbsp;qəhrəman neft&amp;ccedil;ilərinə, onların əməyinə və məişətinə həsr olunmuşdur. Polad dirəklər &amp;uuml;zərində qurulmuş dəniz estakadası y&amp;uuml;z kilometrlərlə dənizin i&amp;ccedil;ərilərinə doğru uzanır, burada igid adamların əlləri ilə neft buruqları və neft&amp;ccedil;ilər şəhəri salınmışdır. Filmdə &amp;ouml;mr&amp;uuml;n&amp;uuml;n yarısını bu adada ke&amp;ccedil;irən adamlar, buraya işləməyə gələn gənclər, onların qarşılıqlı m&amp;uuml;nasibətləri haqqında s&amp;ouml;hbət gedir, xarakterləri a&amp;ccedil;ılıb g&amp;ouml;stərilir.&lt;/span&gt;&lt;/p&gt;",
//                 "active": "1",
//                 "url": "mocuzeler-adasi--26",
//                 "short_metn": "",
//                 "serial_id": "0",
//                 "tv_id": "0",
//                 "og_title": "M&ouml;c&uuml;zələr adası (film, 1963)",
//                 "og_keywords": "M&ouml;c&uuml;zələr adası (film, 1963), surdo mocuzeler adasi",
//                 "og_description": "M&ouml;c&uuml;zələr adası (film, 1963) - Surdotv.az saytında eşitmə əngəlli insanlar &uuml;&ccedil;&uuml;n tərc&uuml;mə edilmiş formada təqdim edilir.",
//                 "image": "mocuzeler-adasi--26_81.jpg",
//                 "baxilib": "609",
//                 "zaman": "1:13:34",
//                 "tarix": "2020-03-21 23:34:32"
//             }