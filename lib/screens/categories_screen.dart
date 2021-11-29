import 'package:flutter/material.dart';

import './selected_category_screen.dart';
import '../widgets/home_page_block.dart';
import '../widgets/common_widgets.dart';


class CategoriesScreen extends StatefulWidget {
  static const route_name = '/categories';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        if (_selectedCategory == '') {
          return true;
        } else {
          setState(() {
            _selectedCategory = '';
          });
          return false;
        }
      },
      child: Scaffold(
        appBar:  AppBar(
                // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.undo))],
                centerTitle: true,
                elevation: 0,
                title:  logoMSize,
                backgroundColor: Theme.of(context).canvasColor,
                leading: _selectedCategory != ''
            ?IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = '';
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded) ,
                  color: Colors.black,
                ) : null,
               
              ),
         
        body: SingleChildScrollView(
          
          child: _selectedCategory != ''
              ? SelectedCategoryScreen(_selectedCategory)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  
                  children: [
                  
                    sub_categories_buttons(),
                    HomePageBlock(
                      leftHeader: 'Filmlər',
                      leftIcon: Icons.videocam_outlined,
                      rightHeader: 'Bütün filmlər',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    HomePageBlock(
                      leftHeader: 'Cizgi Filmlər',
                      leftIcon: Icons.videogame_asset_outlined,
                      rightHeader: 'Bütün cizgi filmlər',
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget sub_categories_buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          1,
          2,
          3,
        ]
            .map(
              (e) => OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = e.toString();
                  });
                },
                child: Text(
                  'ooook$e',
                ),
                style: outlinedButtonStyle,
              ),
            )
            .toList(),
      ),
    );
  }
}
