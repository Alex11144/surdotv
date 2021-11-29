import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class InfoScreen extends StatelessWidget {
  static const route_name = '/info';
  @override
  Widget build(BuildContext context) {
    return Column(
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
              )
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
            'www.surdotv.az video portalı eşitmə və nitq qabiliyyəti olmayan sağlamlıq imkanları məhdud şəxslərin informasiya əldə etmək hüquqlarının təmin olunmasında bərabər imkanların yaradılması məqsədilə Azərbaycan Respublikasının Əmək və Əhalinin Sosial Müdafiəsi Nazirliyinin “Eşitmə və nitq qabiliyyəti olmayan sağlamlıq imkanları məhdud şəxslər üçün kütləvi informasiya vasitələri vasitəsilə surdoloji maarifləndirmə xidmətlərinin aparılması” adlı sosial sifarişinin icrası olaraq “Uşaq və Gənclərin İnkişafına Dəstək” İctimai Birliyi tərəfindən yaradılmışdır.',
            style: TextStyle(fontSize:15,fontFamily: 'Helvetica',fontStyle: FontStyle.normal,),
          ),
        )
      ],
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
