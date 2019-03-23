import 'package:flutter/material.dart';

import './products.dart';
import './firebase_helpers/readImageData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;

  ProductManager({this.startingProduct}) {
    print('[ProductManager Widget] Constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[ProductManager Widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];
  Map<String, String> _images;

  void _addProduct(MapEntry<String, String> product) {
    print('[ProductManagerState:_addProduct] _images = ' + _images.toString());
    setState(() {
      // _products.add(product);
      
      _products.add({
        'title': 'Windsor-Essex DevFest',
        'image': _images['Windsor-Essex DevFest']
      });
    });
    print(_products);
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
    print(_products);
  }

  @override
  void initState() {
    super.initState();
    // _images = ReadImageDataFromFirestore.readData();
    Map<String, String> _cards = new Map<String, String>();
    Firestore.instance
        .collection('CardImages')
        // .where("topic", isEqualTo: "flutter")
        .snapshots()
        .listen((data) {
      data.documents.forEach(
          (doc) => (_cards.putIfAbsent(doc["Name"], () => doc["Image"])));
      print("[ReadImageDataFromFirestore] Cards = " + _cards.toString());
      _images = _cards;
    }, onDone: () {});
    print('[ProductManagerState:initState] _images = ' + _images.toString());
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Stack(children: <Widget>[
      Hero(
        tag: 'GDGWindsorHeroImage',
        child: Image.asset('assets/GDGWindsor.png'),
      ),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
          ),
          Divider(height: 16.0, color: Colors.blueAccent),
          Expanded(child: Products(_products, deleteProduct: _deleteProduct))
        ],
      ),
      Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              print('[ProductManagerState:build] _images = ' +
                  _images.toString());
                  _images.entries.elementAt(0);
                  _addProduct(_images.entries.elementAt(1));
              // _addProduct({'title': 'Chocolate', 'image': 'assets/food.jpg'});
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ))
    ]);
  }
}
