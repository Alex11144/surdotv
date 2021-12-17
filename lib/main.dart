import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/widgets/common_widgets.dart';

import '../helpers/custom_route.dart';
import '../providers/search.dart';
import '../screens/contact_screen.dart';
import '../screens/info_screen.dart';
import '../screens/search_screen.dart';
import '../screens/splash_screen.dart';
import '../providers/menu_data.dart';

import './providers/about.dart';
import './providers/videos.dart';
import './providers/categories.dart';
import './screens/detail_screen.dart';
import './screens/video_player.dart';

import './screens/selected_category_screen.dart';
import './screens/categories_screen.dart';
import './screens/main_page.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _isDark = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
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
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                )),

                textTheme: TextTheme(
                    caption: TextStyle(fontSize: 18, color: Colors.black87)),
                primaryColor: Color.fromRGBO(240, 232, 232, 1),
                canvasColor: Colors.white,
                colorScheme: _isDark
                    ? ColorScheme.dark(
                        secondary: Color.fromRGBO(203, 33, 41, 1),
                        primary: Color.fromRGBO(240, 232, 232, 1),
                      )
                    : ColorScheme.light(
                        secondary: Color.fromRGBO(203, 33, 41, 1),
                        primary: Color.fromRGBO(240, 232, 232, 1),
                      ),
                //  fontFamily: 'Helvetica',

                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                }),
              ),
              home: SplashScreen(),
              routes: {
                CategoriesScreen.route_name: (ctx) => CategoriesScreen(),
                InfoScreen.route_name: (ctx) => InfoScreen(),
                HomePageScreen.route_name: (ctx) => HomePageScreen(),
                SelectedCategoryScreen.routeName: (ctx) =>
                    SelectedCategoryScreen(
                      categoryId: '',
                    ),
                DetailScreen.routeName: (ctx) => DetailScreen(),
                MyVideoPlayer.route_name: (ctx) => MyVideoPlayer(),
                SearchScreen.route_name: (ctx) => SearchScreen(),
                ContactScreen.route_name: (ctx) => ContactScreen(),
              },
            ),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: lightMode
          ? Color.fromRGBO(240, 232, 232, 1)
          : Color.fromRGBO(240, 232, 232, 1),
      body: Center(child: lightMode ? logoMSize : logoMSize),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
