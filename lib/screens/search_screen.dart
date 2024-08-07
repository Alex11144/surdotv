import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surdotv_app/widgets/outline_button_widget.dart';

import '../models/video_item.dart';
import '../providers/search.dart';
import '../widgets/grid_item.dart';
import '../widgets/common_widgets.dart';

class SearchScreen extends StatefulWidget {
  static const route_name = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController edt = new TextEditingController();
  List<VideoItem> _videos = [];
  var _isLoading = false;

  List<String> _mostSearched = [];

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      final _searchData = Provider.of<SearchData>(context, listen: false)
        ..getRecommends();

      setState(() {
        _mostSearched = _searchData.recommendList;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        if (edt.text == '') {
          return true;
        } else {
          setState(() {
            edt.text = '';
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
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
          leading: '' != ''
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      edt.text = '';
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  color: Colors.black,
                )
              : null,
        ),
        //  bottomNavigationBar: BottomNavBar(selectedBar: 3),
        body: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: edt,
                  textInputAction: TextInputAction.search,
                  onChanged: (txt) {
                    if (txt.isNotEmpty) _doSearch(context, txt);
                  },
                  onSubmitted: (txt) {
                    _doSearch(context, txt);
                  },
                  decoration: myInputDecoration(
                    aHintText: 'Axtar ...',
                    // aSuffixIcon: Icons.clear,
                    // aSuffixIcon: Icons.search,
                  ).copyWith(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              edt.clear();
                            });
                          },
                          icon: Icon(
                            edt.text.isEmpty ? Icons.search : Icons.clear,
                            color: Colors.black45,
                          ))),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                opacity: edt.text.isNotEmpty ? 0.0 : 1,
                child: Visibility(
                  visible: !edt.text.isNotEmpty,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    //height: edt.text.isNotEmpty ? 0.0 : ,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _mostSearched
                          .map((e) => OutlineButtonWithAnimation(
                              func: () {
                                edt.text = e;
                                _doSearch(context, e);
                              },
                              txt: e))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ))
                    : OrientationBuilder(builder: (context, orientation) {
                        return GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate: gridDelegate(orientation),
                          itemCount: _videos.length,
                          itemBuilder: ((ctx, i) => GridTile(
                                child: GridItem(
                                    id: _videos[i].id!,
                                    imgUrl: _videos[i].getImageUrl,
                                    title: _videos[i].videoHead??''),
                              )),
                        );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doSearch(BuildContext context, String txt) {
    setState(() {
      _isLoading = true;
    });

    final searchData = Provider.of<SearchData>(context, listen: false);
    searchData.fetchData(txt).then((_) {
      setState(() {
        _videos = searchData.items;
        _isLoading = false;
      });
    });
  }
}
