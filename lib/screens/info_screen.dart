import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/common_widgets.dart';
import '../providers/about.dart';

class InfoScreen extends StatefulWidget {
  static const route_name = '/info';

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool _isLoaded = false;
  String aboutText1 = '';
  String aboutText2 = '';

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {
      print('about provider called' + DateTime.now().toString());
      final aboutProvider = Provider.of<About>(context);
      aboutProvider.fetchAll().then((_) {
        aboutText1 = aboutProvider.content1;
        aboutText2 = aboutProvider.content2;
        print(aboutText1);
        setState(() {
          _isLoaded = !_isLoaded;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !_isLoaded
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  snap: true,
                  floating: true,
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,

                  expandedHeight: Platform.isAndroid ? 160.0 : 160.0,
                  collapsedHeight: Platform.isAndroid ? 60 : 60,

                  shadowColor: Colors.transparent,

                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Container(
                      height: 120,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: logoMSize,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset.zero,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  //  Container(
                  //   height: 160.0,
                  //   alignment: Alignment.center,
                  //   child: logoLSize,

                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).colorScheme.primary,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black26,
                  //         blurRadius: 12,
                  //         offset: Offset.zero,
                  //       ),
                  //     ],
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(35),
                  //       bottomRight: Radius.circular(35),
                  //     ),
                  //   ),
                  // ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              aboutText1 == null ? '' : aboutText1,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          adsBlock(context),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              aboutText2 == null ? '' : aboutText2,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ])
        // : SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         AnimatedContainer(
        //           duration: Duration(milliseconds: 300),
        //           // height: 150,
        //           height: selected ? 150.0 : 50.0,
        //           curve: Curves.fastOutSlowIn,
        //           alignment: Alignment.center,
        //           child: logoLSize,
        //           decoration: BoxDecoration(
        //             color: Theme.of(context).colorScheme.primary,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.black26,
        //                 blurRadius: 12,
        //                 offset: Offset.zero,
        //               ),
        //             ],
        //             borderRadius: BorderRadius.only(
        //               bottomLeft: Radius.circular(35),
        //               bottomRight: Radius.circular(35),
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Text(
        //             aboutText == null ? '' : aboutText,
        //             style: TextStyle(
        //                 fontSize: 16,
        //                 fontFamily: 'Helvetica',
        //                 fontStyle: FontStyle.normal),
        //             textAlign: TextAlign.justify,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         adsBlock(context),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Text(
        //             'www.surdotv.az video portalı eşitmə və nitq qabiliyyəti olmayan sağlamlıq imkanları məhdud şəxslərin informasiya əldə etmək hüquqlarının təmin olunmasında bərabər imkanların yaradılması məqsədilə Azərbaycan Respublikasının Əmək və Əhalinin Sosial Müdafiəsi Nazirliyinin “Eşitmə və nitq qabiliyyəti olmayan sağlamlıq imkanları məhdud şəxslər üçün kütləvi informasiya vasitələri vasitəsilə surdoloji maarifləndirmə xidmətlərinin aparılması” adlı sosial sifarişinin icrası olaraq “Uşaq və Gənclərin İnkişafına Dəstək” İctimai Birliyi tərəfindən yaradılmışdır.',
        //             style: TextStyle(
        //                 fontSize: 16,
        //                 fontFamily: 'Helvetica',
        //                 fontStyle: FontStyle.normal),
        //             textAlign: TextAlign.justify,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        );
  }
}
// font-family: Helvetica Neue;
// font-size: 14px;
// font-style: normal;
// font-weight: 400;
// line-height: 22px;
// letter-spacing: 0em;
// text-align: justified;
