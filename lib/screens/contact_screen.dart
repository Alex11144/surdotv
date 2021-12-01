import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  static const route_name = '/contact';
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   childAspectRatio: 10 / 3,
                    //   crossAxisCount: 2,
                    //   crossAxisSpacing: 8,
                    //   mainAxisSpacing: 8,
                    // ),

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
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email: info@surdotv.az'),
                          TextButton(
                            onPressed: () {},
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
