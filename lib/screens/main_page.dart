import 'package:flutter/material.dart';

import '../screens/search_screen.dart';
import './info_screen.dart';
import './selected_category_screen.dart';
import './categories_screen.dart';
import './home_screen.dart';

class HomePageScreen extends StatefulWidget {
  static const route_name = '/home-page';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Map<String, Object>> _pages;
  var _selecedPageIndex;

  @override
  void initState() {
    _selecedPageIndex = 0;
    _pages = [
      {
        'title': 'Home',
        'page': HomeScreen(),
      },
      {
        'title': 'Info',
        'page': InfoScreen(),
      },
      {
        'title': 'Categoties',
        'page': CategoriesScreen(),
      },
      {
        'title': 'Search',
        'page': SearchScreen(),
      },
      {
        'title': 'Messages',
        'page': null,
      },
      {
        'title': 'Selected Category',
        'page': SelectedCategoryScreen(''),
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selecedPageIndex]['page'],
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget BottomNavBar() {
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
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: _selecedPageIndex, // _selected_index,
            onTap: (index) {
              setState(() {
                _selecedPageIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
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
          ),
        ));
  }
}
