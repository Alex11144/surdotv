import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './selected_category_screen.dart';
import '../widgets/home_page_block.dart';
import '../widgets/common_widgets.dart';
import '../providers/categories.dart';


class CategoriesScreen extends StatefulWidget {
  static const route_name = '/categories';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _selectedCategory = '';
  

  @override
  Widget build(BuildContext context) {
    final _categories = Provider.of<Categories>(context, listen: false);
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
                  
                    sub_categories_buttons(_categories),
                    HomePageBlock(
                      leftHeader: _categories.items[0].name,
                    leftIcon: Icons.videocam_outlined,
                    rightHeader: 'Bütün filmlər',
                    videoList: _categories.items[0].videoList,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    HomePageBlock(
                     leftHeader: _categories.items[1].name,
                  leftIcon: Icons.videogame_asset_outlined,
                  rightHeader: 'Bütün cizgi filmlər',
                  videoList: _categories.items[1].videoList,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget sub_categories_buttons(Categories categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: categories.items 
            .map(
              (e) => OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = e.id;
                  });
                },
                child: Text(
                  e.name
                ),
                style: outlinedButtonStyle,
              ),
            )
            .toList(),
      ),
    );
  }
}
