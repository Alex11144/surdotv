import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/providers/videos.dart';
import 'package:surdotv_app/widgets/outline_button_widget.dart';

import './selected_category_screen.dart';
import '../widgets/home_page_block.dart';
import '../widgets/common_widgets.dart';
import '../providers/categories.dart';
import '../providers/menu_data.dart';

class CategoriesScreen extends StatefulWidget {
  static const route_name = '/categories';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _selectedCategory = '';

  @override
  void didChangeDependencies() {
    //  _selectedCategory = (ModalRoute.of(context).settings.arguments as Map<String, String>)['catId'] ;
    //  print(_selectedCategory);
    final menuData = Provider.of<MenuData>(context);
    _selectedCategory = menuData.selectedCategoryId;
    _selectedCategory = '';
    print('selectedd = $_selectedCategory');
    super.didChangeDependencies();
  }

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
        appBar: AppBar(
          // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.undo))],
          centerTitle: true,
          elevation: 0,
          title: logoMSize,
          backgroundColor: Theme.of(context).canvasColor,
          leading: _selectedCategory != ''
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = '';
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  color: Colors.black,
                )
              : null,
        ),
        // bottomNavigationBar: BottomNavBar(selectedBar: 2),
        body: SingleChildScrollView(
          child: _selectedCategory != ''
              ? SelectedCategoryScreen(
                  categoryId: _selectedCategory,
                  catTitle: _categories.items
                      .firstWhere((e) => e.id == _selectedCategory)
                      .name,
                  catIcon: _categories.items
                              .indexWhere((e) => e.id == _selectedCategory) ==
                          0
                      ? vCamera
                      : svgcartoon)
              : _categories.items.length == 0
                  ? Center(child: Text('Serverlə əlaqə yaradıla bilmədi..'))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        sub_categories_buttons(_categories),
                        HomePageBlock(
                          leftHeader: _categories.items[0].name,
                          leftIcon: vCamera, //Icons.videocam_outlined,
                          rightHeader: 'Bütün filmlər',
                          videoList: _categories.items[0].videoList,
                          catId: _categories.items[0].id,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        HomePageBlock(
                          leftHeader: _categories.items[1].name,
                          leftIcon:
                              svgcartoon, //Icons.videogame_asset_outlined,
                          rightHeader: 'Bütün cizgi filmlər',
                          videoList: _categories.items[1].videoList,
                          catId: _categories.items[1].id,
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
              (e) => OutlineButtonWithAnimation(
                  func: () {
                    setState(() {
                      _selectedCategory = e.id;
                    });
                  },
                  txt: e.name),
            )
            .toList(),
      ),
    );
  }
}
