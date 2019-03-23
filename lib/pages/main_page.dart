import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../product_manager.dart';
import '../firebase_helpers/readImageData.dart';

class MainPage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

MainPage({this.analytics, this.observer});

  Future<void> _setAnalyticsCurrentScreen() async {
    await analytics.setCurrentScreen(
      screenName: 'Main Product List Page',
      screenClassOverride: 'ProductList',
    );
    print('Analytics: setCurrentScreen done');
  }

 void _setupPushNotifications(){
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print("### token for phone: ${token}");
    });
    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      _onPushNotification(message.toString());
    },
    onResume: (Map<String, dynamic> message) {
      _onPushNotification(message.toString());
    },
    onLaunch: (Map<String, dynamic> message) {
      _onPushNotification(message.toString());
    });
 }

void _onPushNotification(String message){
  print ('[MainPage]<onPushNotification> - method called');
}

  @override
  Widget build(BuildContext context) {
    _setAnalyticsCurrentScreen();
    _setupPushNotifications();
    // ReadImageDataFromFirestore.readData();
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
