import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart_provider/Model/Product.dart';
import 'package:shop_cart_provider/Provider/MyProvider.dart';
import 'package:shop_cart_provider/Screens/Favorite_details.dart';
import 'package:shop_cart_provider/Screens/Product_details.dart';
import 'package:shop_cart_provider/Widget/cardData.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool lood = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MyProvider>(context, listen: false)
          .FetchDataFavorite()
          .then((value) => lood = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> product = Provider.of<MyProvider>(context).favoriteProduct;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Product"),
        centerTitle: true,
      ),
      body: Provider.of<MyProvider>(context).loading || lood == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          : product.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      itemCount: product.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavoriteDetails(
                                          id: product[index].id)),
                                );
                              },
                              child: CardData(
                                  image: product[index].image,
                                  title: product[index].title,
                                  price: product[index].price),
                            )
                          ],
                        );
                      }),
                )
              : Center(
                  child: Text("There are no products"),
                ),
    );
  }
}
