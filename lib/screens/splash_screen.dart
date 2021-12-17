import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/categories.dart';
import '../providers/videos.dart';
import '../screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {
      final _catProvider = Provider.of<Categories>(
        context,
        listen: false,
      );

      if (!_catProvider.isLoaded) {
        _catProvider.fetchAll().then((value) {
          Navigator.of(context).pushReplacementNamed(HomePageScreen.route_name);
        });
      }

      final _videoProvider = Provider.of<Videos>(
        context,
        listen: false,
      );

      if (!_videoProvider.isLoaded) {
        _videoProvider.fetchAll();
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
