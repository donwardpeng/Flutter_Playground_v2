import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';

import '../product_manager.dart';
import '../firebase_helpers/readImageData.dart';

class MainPage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

MainPage({this.analytics, this.observer});

  Future<void> _setAnalyticsCurrentScreen() async {
    await analytics.setCurrentScreen(
      screenName: 'Main Product List Page',
      screenClassOverride: 'ProductList',
    );
    print('Analytics: setCurrentScreen done');
  }

  @override
  Widget build(BuildContext context) {
    _setAnalyticsCurrentScreen();
    ReadImageDataFromFirestore.readData();
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
        },
        child: Scaffold(
          drawer: Drawer(
              child: Column(
            children: <Widget>[
              AppBar(title: Text("Choose")),
              ListTile(
                title: Text('About'),
              )
            ],
          )),
          appBar: AppBar(
            title: Text('EasyList'),
          ),
          body: ProductManager(),
        ));
  }
}
