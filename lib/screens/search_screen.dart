import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController edt;

  final List<String> _mostSearched = [
    'Yerli filmlər',
    'Qısametrajlı filmlər',
    'Qısametrajlı filmlər'
  ];

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
        body: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 70,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: edt,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  decoration: myInputDecoration(aHintText: 'Axtar ...',aSuffixIcon: Icons.search,),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _mostSearched
                      .map((e) => OutlinedButton(
                            onPressed: () {},
                            child: Text(e),
                            style: outlinedButtonStyle,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
