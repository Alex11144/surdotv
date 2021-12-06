import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/providers/menu_data.dart';
import 'package:surdotv_app/providers/search.dart';
import 'package:surdotv_app/screens/splash_screen.dart';

import './providers/about.dart';
import './providers/videos.dart';
import './providers/categories.dart';
import './screens/detail_screen.dart';
import './screens/video_player.dart';

import './screens/selected_category_screen.dart';
import './screens/categories_screen.dart';
import './test_widget.dart';
import './screens/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _isDark = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Categories(context)),
        ChangeNotifierProvider(create: (ctx) => Videos()),
        ChangeNotifierProvider(create: (ctx) => About()),
        ChangeNotifierProvider(create: (ctx) => MenuData()),
        ChangeNotifierProvider(create: (ctx) => SearchData()),
      ],
      child: MaterialApp(
        title: 'Surdo TV App',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(240, 232, 232, 1),
          canvasColor: Colors.white,
          colorScheme: _isDark
              ? ColorScheme.dark(
                  secondary: Colors.red,
                  primary: Color.fromRGBO(240, 232, 232, 1),
                )
              : ColorScheme.light(
                  secondary: Colors.red,
                  primary: Color.fromRGBO(240, 232, 232, 1),
                ),
          //  fontFamily: 'Helvetica',
        ),
        home: SplashScreen(),
        routes: {
          CategoriesScreen.route_name: (ctx) => CategoriesScreen(),
          HomePageScreen.route_name: (ctx) => HomePageScreen(),
          SelectedCategoryScreen.routeName: (ctx) => SelectedCategoryScreen(''),
          DetailScreen.routeName: (ctx) => DetailScreen(),
          MyVideoPlayer.route_name: (ctx) => MyVideoPlayer(),
        },
      ),
    );
  }
}
