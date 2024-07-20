import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../screens/contact_screen.dart';
import '../screens/home_screen.dart';
import '../screens/main_page.dart';
import '../screens/search_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/info_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int? selectedBar;
  BottomNavBar({this.selectedBar});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Map<String, Object>> _pages = [
    {
      'title': 'Baş səhifə',
      'page': HomeScreen(),
      'icon': Icon(Icons.home),
    },
    {
      'title': 'Haqqımızda',
      'page': InfoScreen(),
      'icon': Icon(Icons.info_outline),
    },
    {
      'title': 'Bölmələr',
      'page': CategoriesScreen(),
      'icon': Icon(Icons.menu),
    },
    {
      'title': 'Axtarış',
      'page': SearchScreen(),
      'icon': Icon(Icons.search),
    },
    {
      'title': 'Əlaqə',
      'page': ContactScreen(),
      'icon': Icon(Icons.mail_outline),
    },
    // ,
    // {
    //   'title': 'Selected Category',
    //   'page': SelectedCategoryScreen(''),
    //   'icon': Icon(Icons.info_outline),
    // }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavyBar(
              selectedIndex: widget.selectedBar!,
              animationDuration: Duration(milliseconds: 300),
              showElevation: true,
              itemCornerRadius: 25,
              onItemSelected: (index) {
                //Navigator.of(context).pushReplacementNamed(_pages[index]['routeName']);
                // _pageController.jumpToPage(
                //   index,
                // );
                switch (index) {
                  case 0:
                    Navigator.pushReplacementNamed(
                        context, HomePageScreen.route_name);
                    break;
                  case 1:
                    Navigator.pushReplacementNamed(
                        context, InfoScreen.route_name);
                    break;
                  case 2:
                    Navigator.pushReplacementNamed(
                        context, CategoriesScreen.route_name);
                    break;
                  case 3:
                    Navigator.pushReplacementNamed(
                        context, SearchScreen.route_name);
                    break;
                  case 4:
                    Navigator.pushReplacementNamed(
                        context, ContactScreen.route_name);
                    break;
                }
              },
              items: <BottomNavyBarItem>[
                ..._pages
                    .map((e) => BottomNavyBarItem(
                          activeColor: Theme.of(context).colorScheme.error,
                          inactiveColor: Colors.black,
                          title: Text(e['title'].toString()),
                          icon: e['icon']as Widget,
                        ))
                    .toList()
              ],
            ),
            //bottomNavBarNormal(context, widget.selectedBar),
          ),
        ),
      ),
    );
  }
}

Widget bottomNavBarNormal(BuildContext context, int selIndex) {
  return BottomNavigationBar(
    unselectedItemColor: Colors.black,
    selectedItemColor: Theme.of(context).colorScheme.secondary,
    currentIndex: selIndex, // _selected_index,
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, HomePageScreen.route_name);
          break;
        case 1:
          Navigator.pushReplacementNamed(context, InfoScreen.route_name);
          break;
        case 2:
          Navigator.pushReplacementNamed(context, CategoriesScreen.route_name);
          break;
        case 3:
          Navigator.pushReplacementNamed(context, SearchScreen.route_name);
          break;
        case 4:
          Navigator.pushReplacementNamed(context, ContactScreen.route_name);
          break;
      }
    },
    type: BottomNavigationBarType.shifting,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        activeIcon: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Icon(Icons.home),
            AnimatedAlign(
                alignment: Alignment.topCenter,
                duration: Duration(microseconds: 1000),
                child: Text('Baş səhifə')),
          ],
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'Info',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: 'Sections',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.mail_outline),
        label: 'Message',
      ),
    ],
  );
}
