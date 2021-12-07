import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/common_widgets.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  static const route_name = '/contact';
  final _form = GlobalKey<FormState>();

  Future<void> _saveFrom() async {
    if (_form.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }

    // _form.currentState.validate();
    // _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.undo))],
        centerTitle: true,
        elevation: 0,
        title: logoMSize,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
      ),
      body: Container(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    svgMail,
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Bizimlə Əlaqə',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(right: 5),
                              child: TextFormField(
                                decoration:
                                    myInputDecoration(aHintText: 'Ad Soyad *'),
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty || val == null) {
                                    return 'Ad Soyad boş ola bilməz';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(left: 5),
                              child: TextFormField(
                                decoration:
                                    myInputDecoration(aHintText: 'E-mail *'),
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Email boş ola bilməz';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(right: 5),
                              child: TextFormField(
                                decoration:
                                    myInputDecoration(aHintText: 'Mobil *'),
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Mobil boş ola bilməz';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(left: 5),
                              child: TextFormField(
                                decoration:
                                    myInputDecoration(aHintText: 'Şəhər *'),
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Şəhər boş ola bilməz';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: myInputDecoration(aHintText: 'Mesajınız '),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Mesaj boş ola bilməz';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email: info@surdotv.az'),
                          TextButton(
                            onPressed: () {
                              if (_form.currentState.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            child: Text('Mesajı Göndər'),
                            style: redFilledButtonStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    svgMapPin,
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Ünvan',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
