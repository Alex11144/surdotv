import 'package:flutter/material.dart';
import 'package:surdotv_app/screens/detail_screen.dart';

import './screens/selected_category_screen.dart';
import 'screens/categories_screen.dart';
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
    return MaterialApp(
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
      home: HomePageScreen(),
      routes: {
        CategoriesScreen.route_name: (ctx) => CategoriesScreen(),
        HomePageScreen.route_name: (ctx) => HomePageScreen(),
        SelectedCategoryScreen.routeName: (ctx) => SelectedCategoryScreen(''),
        DetailScreen.routeName: (ctx) => DetailScreen(),
      },
    );
  }
}
