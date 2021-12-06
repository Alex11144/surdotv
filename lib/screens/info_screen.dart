import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/common_widgets.dart';
import '../providers/about.dart';

class InfoScreen extends StatelessWidget {
  static const route_name = '/info';

  @override
  Widget build(BuildContext context) {
    final aboutProvider = Provider.of<About>(context, listen: false);
    final aboutText = aboutProvider.getContent();
    return !aboutProvider.isLoaded
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: logoLSize,
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
                    aboutText == null ? '':aboutText,
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
