import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';

import '../widgets/common_widgets.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> _imgList = [
    'https://surdotv.az/uploads/bir-qalanin-sirri--196_51.jpg',
    'https://surdotv.az/uploads/min-bir-ilme---197_29.jpg',
    'https://surdotv.az/uploads/asif--vasif--agasif--193_51.jpg',
  ]
      .map((e) => Image.network(
            e,
            fit: BoxFit.fill,
          ))
      .toList();

  CarouselController buttonCarouselController = CarouselController();

  Animation<double> _animation;
  AnimationController _animationController;
  var _animated = false;

  @override
  void initState() {
    animateShareIcons();
    super.initState();
  }

  void animateShareIcons() {
    _animated = !_animated;
    if (_animationController == null) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
      );
    } else {
      _animationController.reset();
    }
    _animation = Tween<double>(
            begin: _animated ? 120 : -120, end: _animated ? -120 : 120)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                      //
                    }
                    //
                    ),
                items: _imgList.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(children: [
                        SizedBox(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            child: item,
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
                              onTap: () {},
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
              children: [
                ListTile(
                  title: Text(
                    'Xoştbəxtlik qayğıları',
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
                          DateFormat.yMd()
                              .add_Hms()
                              .format(DateTime.now())
                              .toString(),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 15,
                          color: Colors.black45,
                        ),
                        Text('1521 baxış'),
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
                    'Musiqili film uşaq aləminin gözəlliyindən, onların xarakterlərindən, uşaqlarla heyvanların dostluğundan bəhs edir.',
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
                        left: _animation.value,
                        child: Container(
                          color: Colors.orange,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 20,
                          width: 120,
                          child: const FlutterLogo(),
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
