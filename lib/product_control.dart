import 'package:flutter/material.dart';
import './firebase_helpers/readImageData.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    Map<String,String> _images = ReadImageDataFromFirestore.readData();
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        print ('Printing from the map ' + _images["Windsor-Essex DevFest"]);
        addProduct({'title': 'Chocolate', 'image': 'assets/food.jpg'});
      },
      child: Text('Add Product'),
    );
  }
}
