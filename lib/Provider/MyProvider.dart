import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_cart_provider/Model/Product.dart';
import 'package:http/http.dart' as http;

class MyProvider with ChangeNotifier {
  List<Product> product = [];
  List<Product> favoriteProduct = [];

  final String url =
      "https://shopcart-e4407-default-rtdb.firebaseio.com/product.json";
  bool loading = false;
  Future<void> addProduct(
    String title,
    String price,
    String image,
  ) async {
    loading = true;
    await http
        .post(Uri.parse(url),
            body: json.encode({
              'title': title,
              'price': price,
              'image': image,
            }))
        .then((res) => product.add(
              Product(
                id: json.decode(res.body)['name'],
                image: image,
                title: title,
                price: price,
              ),
            ));
    loading = false;
    notifyListeners();
  }

  Product Productdetails(String id) {
    return product.firstWhere((element) => element.id == id);
  }

  Future<void> Productdelete(String id) async {
    loading = true;

    final url =
        "https://shopcart-e4407-default-rtdb.firebaseio.com/product/$id.json";
    final prodIndex = product.indexWhere((element) => element.id == id);
    product.removeAt(prodIndex);
    await http.delete(Uri.parse(url));
    loading = false;

    notifyListeners();
  }

  Future<void> ProductFavorite(String id) async {
    loading = true;

    final String url =
        "https://shopcart-e4407-default-rtdb.firebaseio.com/productFavorite.json";
    Product element = product.firstWhere((element) => id == element.id);
    await http
        .post(Uri.parse(url),
            body: json.encode({
              'title': element.title,
              'price': element.price,
              'image': element.image,
            }))
        .then((value) => favoriteProduct
            .add(product.firstWhere((element) => element.id == id)));
    loading = false;

    notifyListeners();
  }

  Future<void> Favoritdelete(String id) async {
    final url =
        "https://shopcart-e4407-default-rtdb.firebaseio.com/productFavorite/$id.json";
    final prodIndex = favoriteProduct.indexWhere((element) => element.id == id);
    favoriteProduct.removeAt(prodIndex);
    await http.delete(Uri.parse(url));

    notifyListeners();
  }

  Future<void> FetchData() async {
    final String url =
        "https://shopcart-e4407-default-rtdb.firebaseio.com/product.json";
    try {
      final http.Response res = await http.get(Uri.parse(url));
      final extecttedData = jsonDecode(res.body) as Map<String, dynamic>;
      extecttedData.forEach((productId, products) {
        product.add(
          Product(
              id: productId,
              image: products['image'],
              title: products['title'],
              price: products['price']),
        );
      });
    } catch (e) {}
    notifyListeners();
  }

  Future<void> FetchDataFavorite() async {
    final String url =
        "https://shopcart-e4407-default-rtdb.firebaseio.com/productFavorite.json";
    try {
      final http.Response res = await http.get(Uri.parse(url));
      final extecttedData = jsonDecode(res.body) as Map<String, dynamic>;
      extecttedData.forEach((productId, products) {
        favoriteProduct.add(
          Product(
              id: productId,
              image: products['image'],
              title: products['title'],
              price: products['price']),
        );
      });
    } catch (e) {}

    notifyListeners();
  }
}
