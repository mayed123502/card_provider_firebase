import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart_provider/Model/Product.dart';
import 'package:shop_cart_provider/Provider/MyProvider.dart';
import 'package:shop_cart_provider/Screens/DataEntry.dart';
import 'package:shop_cart_provider/Screens/Favorite.dart';
import 'package:shop_cart_provider/Screens/Product_details.dart';
import 'package:shop_cart_provider/Widget/cardData.dart';

import 'fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool lood = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MyProvider>(context, listen: false)
          .FetchData()
          .then((value) => lood = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> product = Provider.of<MyProvider>(context).product;

    return Scaffold(
      backgroundColor: Color(int.parse("0xff${hexString1}")),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Shopping cart"),
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
                                      builder: (context) => ProductDetails(
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DataEntry()),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favorite()),
                );
              },
              title: Text(
                'Favorite Product',
                style: TextStyle(fontSize: 25),
              ),
              trailing: Icon(
                Icons.star,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
