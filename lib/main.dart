import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/providers/vimeo_api.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Categories(context)),
        ChangeNotifierProvider(create: (ctx) => Videos()),
        ChangeNotifierProvider(create: (ctx) => About()),
        ChangeNotifierProvider(create: (ctx) => MenuData()),
        ChangeNotifierProvider(create: (ctx) => SearchData()),
        ChangeNotifierProvider(create: (ctx) => VimeoApi()),
      ],
      child: MaterialApp(
        title: 'Surdo TV App',
        builder: (ctx, child) {
          final _screenWidth = MediaQuery.of(ctx).size.width;
          final _scaleFactor = _screenWidth > 600
              ? 1.15
              : _screenWidth < 350
                  ? 0.85
                  : 1.0;
          print(_screenWidth);
          return Theme(
              data: ThemeData(
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                )),
                textTheme: TextTheme(
                  caption: TextStyle(
                    fontSize: 16 * _scaleFactor,
                    color: Colors.black87,
                  ),
                  headline6: TextStyle(
                    fontSize: 16 * _scaleFactor,
                  ),
                  button: TextStyle(
                    fontSize: 14 * _scaleFactor,
                  ),
                ),
                iconTheme:
                    IconThemeData(size: _screenWidth < 350 ? 20.0 : 30.0),
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
                fontFamily: 'Helvetica',
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                }),
              ),
              child: child);
        },
        home: SplashScreen(),
        routes: {
          CategoriesScreen.route_name: (ctx) => CategoriesScreen(),
          InfoScreen.route_name: (ctx) => InfoScreen(),
          HomePageScreen.route_name: (ctx) => HomePageScreen(),
          SelectedCategoryScreen.routeName: (ctx) => SelectedCategoryScreen(
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
}
