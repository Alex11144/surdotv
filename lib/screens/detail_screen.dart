import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

import 'package:surdotv_app/models/video_item.dart';
import 'package:surdotv_app/widgets/bottom_nav_bar.dart';

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
  String _header;
  String _dt;
  String _viewed;
  String _txt;
  String _videoUrl;

  CarouselController buttonCarouselController = CarouselController();
  ScrollController listScrollController = ScrollController();

  Animation<double> _animation;

  AnimationController _animationController;
  var _animated = false;
  var _animatedInit = false;
  var _isLoaded = false;

  Videos allVideos;
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
      final videoId = (ModalRoute.of(context).settings.arguments
          as Map<String, String>)['id'];

      allVideos = Provider.of<Videos>(context, listen: true);

      if (allVideos.isLoaded) {
        print('loaded video = ${allVideos.items.length}');

        VideoItem _video = allVideos.items.firstWhere((e) => e.id == videoId);
        if (_video != null) {
          _similarItems = allVideos.similarItems(5, _video.id);
          _video = _video;
          _header = _video.videoHead;
          _dt = _video.dt;
          _viewed = _video.viewed;
          _txt = _video.videoAbout;
          _videoUrl = _video.getVideoUrl;
          _isLoaded = true;
        }
      }
    }

    super.didChangeDependencies();
  }

  _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share('text',
        subject: 'aaaa',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
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
      body: !allVideos.isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                              _header = _similarItems[index].videoHead;
                              _dt = _similarItems[index].dt;
                              _viewed = _similarItems[index].viewed;
                              _txt = _similarItems[index].videoAbout;
                              if (listScrollController.hasClients) {
                                final position = listScrollController
                                    .position.minScrollExtent;
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
                                  child: CachedNetworkImage(
                                    imageUrl: item.getImageUrl,
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
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
                                      onTap: () => _onShare(context),
                                    ),
                                    InkWell(
                                      child: svgFacebook,
                                      onTap: () {
                                        _onShare(context);
                                      },
                                    ),
                                    InkWell(
                                      child: svgWhatsapp,
                                      onTap: () async {
                                        await Share.share(
                                          _videoUrl,
                                        );
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
