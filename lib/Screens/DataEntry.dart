import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart_provider/Provider/MyProvider.dart';
import 'package:shop_cart_provider/main.dart';

class DataEntry extends StatelessWidget {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Product"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      buildTextFormField("Enter Title here", _titleController),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextFormField("Enter Price here", _priceController),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextFormField("Enter Image here", _imageController),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: MaterialButton(
                            color: Colors.greenAccent,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Provider.of<MyProvider>(context, listen: false)
                                    .addProduct(
                                  _titleController.text,
                                  _priceController.text,
                                  _imageController.text,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  TextFormField buildTextFormField(
      String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'This field cannot be left empty';
        }
        return null;
      },
    );
  }
}
