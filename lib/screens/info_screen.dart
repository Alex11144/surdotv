import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/widgets/bottom_nav_bar.dart';

import '../widgets/common_widgets.dart';
import '../providers/about.dart';

class InfoScreen extends StatefulWidget {
  static const route_name = '/info';

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    bool selected = false;
    final aboutProvider = Provider.of<About>(context);
    final aboutText = aboutProvider.getContent();

    setState(() {
      selected = !selected;
    });

    return Scaffold(
      // bottomNavigationBar: BottomNavBar(selectedBar: 1),
      body: !aboutProvider.isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    // height: 150,
                    height: selected ? 150.0 : 50.0,
                    curve: Curves.fastOutSlowIn,
                    alignment: Alignment.center,
                    child: Hero(tag: 'logo', child: logoLSize),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset.zero,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      aboutText == null ? '' : aboutText,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  adsBlock(context),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'www.surdotv.az video portalı eşitmə və nitq qabiliyyəti olmayan sağlamlıq imkanları məhdud şəxslərin informasiya əldə etmək hüquqlarının təmin olunmasında bərabər imkanların yaradılması məqsədilə Azərbaycan Respublikasının Əmək və Əhalinin Sosial Müdafiəsi Nazirliyinin “Eşitmə və nitq qabiliyyəti olmayan sağlamlıq imkanları məhdud şəxslər üçün kütləvi informasiya vasitələri vasitəsilə surdoloji maarifləndirmə xidmətlərinin aparılması” adlı sosial sifarişinin icrası olaraq “Uşaq və Gənclərin İnkişafına Dəstək” İctimai Birliyi tərəfindən yaradılmışdır.',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
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
