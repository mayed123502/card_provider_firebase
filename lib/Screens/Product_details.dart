import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart_provider/Model/Product.dart';
import 'package:shop_cart_provider/Provider/MyProvider.dart';

class ProductDetails extends StatelessWidget {
  final String id;

  ProductDetails({
    @required this.id,
  });
  @override
  Widget build(BuildContext context) {
    Product detail =
        Provider.of<MyProvider>(context, listen: false).Productdetails(id);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Details ${detail.title}"),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Image.network(
                detail.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Name Product :  ${detail.title}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Price Product :  ${detail.price}",
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () async {
                await Provider.of<MyProvider>(context, listen: false)
                    .Productdelete(id);

                Navigator.pop(context);
              },
              child: Icon(Icons.delete),
            ),
            SizedBox(
              width: 227,
            ),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () async {
                await Provider.of<MyProvider>(context, listen: false)
                    .ProductFavorite(id);
                Navigator.pop(context);

              },
              child: Icon(Icons.star),
            ),
          ],
        ));
  }
}
