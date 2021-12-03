import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/models/video_item.dart';

import '../providers/videos.dart';
import '../screens/video_player.dart';

import '../widgets/common_widgets.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> _imgList = [];
  String _header;
  String _dt;
  String _viewed;
  String _txt;

  CarouselController buttonCarouselController = CarouselController();
  ScrollController listScrollController = ScrollController();

  Animation<double> _animation;
  Animation<double> _animation2;
  AnimationController _animationController;
  var _animated = false;
  var _animatedInit = false;
  var _isLoaded = false;
  VideoItem _video;
  List<VideoItem> _similarItems;

  @override
  void initState() {
    //  animateShareIcons();
    super.initState();
  }

  void animateShareIcons() {
    _animatedInit = true;

    if (_animationController == null) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      );
    } else {
      _animationController.reset();
    }
    _animation2 = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
    _animation = Tween<double>(
      begin: _animated ? 50.0 : -110.0,
      end: _animated ? -110.0 : 50.0,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
    _animated = !_animated;
    _animationController.forward();
  }

  @override
  void dispose() {
    if (_animationController != null) _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {
      final videoId = ModalRoute.of(context).settings.arguments;
      final allVideos = Provider.of<Videos>(context, listen: false);
      VideoItem _video = allVideos.items.firstWhere((e) => e.id == videoId);
      _similarItems = allVideos.similarItems(5, _video.id);
      _video = _video;
      _header = _video.videoHead;
      _dt = _video.dt;
      _viewed = _video.viewed;
      _txt = _video.videoAbout;
      _isLoaded = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.undo))],
        centerTitle: true,
        elevation: 0,
        title: logoMSizeWhite,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Column(
        children: [
          Container(
            child: Stack(children: [
              Container(
                height: 130,
                color: Theme.of(context).colorScheme.secondary,
              ),
              CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    height: 200,
                    //viewportFraction: 2,
                    enlargeCenterPage: true,
                    //viewportFraction: 0.5,
                    onPageChanged: (index, r) {
                      setState(() {
                        _video = _similarItems[index];
                        _header = _similarItems[index].videoHead;
                        _dt = _similarItems[index].dt;
                        _viewed = _similarItems[index].viewed;
                        _txt = _similarItems[index].videoAbout;
                        if (listScrollController.hasClients) {
                          final position =
                              listScrollController.position.minScrollExtent;
                          listScrollController.jumpTo(position);
                        }
                        print(index);
                      });
                    }
                    //
                    ),
                items: _similarItems.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(children: [
                        SizedBox(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            child: Image.network(
                              item.getImageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    MyVideoPlayer.route_name,
                                    arguments: item.videoUrl);
                              },
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ]);
                    },
                  );
                }).toList(),
              ),
            ]),
          ),
          Expanded(
            child: ListView(
              controller: listScrollController,
              children: [
                ListTile(
                  title: Text(
                    _header,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 15,
                          color: Colors.black45,
                        ),
                        Text(
                          _dt,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 15,
                          color: Colors.black45,
                        ),
                        Text(_viewed),
                      ],
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      buttonCarouselController.nextPage();
                    },
                    child: TextButtonWithSubfixIconChild(
                      label: Text(
                        'Digər',
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    _txt,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Helvetica',
                        fontStyle: FontStyle.normal),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      InkWell(
                        child: svgShareNetwork,
                        onTap: animateShareIcons,
                      ),
                      Positioned(
                        left: _animatedInit ? _animation.value : -120,
                        child: Container(
                          child: Row(
                            children: [
                              InkWell(
                                child: svgTwitter,
                                onTap: () {
                                  print('twit');
                                },
                              ),
                              InkWell(
                                child: svgFacebook,
                                onTap: () {
                                  print('fb');
                                },
                              ),
                              InkWell(
                                child: svgWhatsapp,
                                onTap: () {
                                  print('wp');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
