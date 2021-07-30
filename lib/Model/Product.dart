import 'package:flutter/material.dart';

class Product {
  final String id;

  final String title;
  final String price;
  final String image;

  Product( {
    @required  this.id,
    @required this.title,
    @required this.price,
    @required this.image,
  });
}
