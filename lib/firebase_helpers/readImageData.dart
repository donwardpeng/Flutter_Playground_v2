import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadImageDataFromFirestore {
  //method to read all of the data from the dpd collection
  static Map<String, String> readData() {
    Map<String, String> _cards = new Map<String, String>();
    Firestore.instance
        .collection('CardImages')
        // .where("topic", isEqualTo: "flutter")
        .snapshots()
        .listen((data) {
      data.documents
          .forEach((doc) => (_cards.putIfAbsent(doc["Name"], ()=> doc["Image"])));
      print ("Cards = " + _cards.toString());
      return _cards;
    }, onDone: () {
      print('Done called');
    });
  }
}
