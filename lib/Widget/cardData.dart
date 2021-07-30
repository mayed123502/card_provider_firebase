import 'package:flutter/material.dart';

class CardData extends StatelessWidget {

  final String title;
  final String price;
  final String image;

  CardData({
    @required this.title,
    @required this.price,
    @required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Container buildContainer() {
    return Container(
    height: 180,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network("$image"),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 45, horizontal: 20),
          child: Column(
            children: [
              Text(
                "$title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "\$",
                      style: TextStyle(color: Colors.black.withOpacity(.5)),
                    ),
                  ),
                  Text(
                    "$price",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
  }
}
