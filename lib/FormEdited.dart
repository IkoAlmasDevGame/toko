import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toko/Home.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

class EditedProduct extends StatefulWidget {
  Product products;
  VoidCallback resfreshProducts;

  EditedProduct({required this.products, required this.resfreshProducts});

  @override
  State<EditedProduct> createState() => _EditedProductState();
}

class _EditedProductState extends State<EditedProduct> {
  final formKey = GlobalKey<FormState>();

  check(){
    final key = formKey.currentState;
    if (key!.validate()){
      key.save();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Home()));
    }
  }

  late TextEditingController namaProduct;
  late TextEditingController hargaProduct;
  late TextEditingController stockProduct;

  setUp(){
    namaProduct = TextEditingController(text: widget.products.namaProduct);
    hargaProduct = TextEditingController(text: widget.products.hargaProduct);
    stockProduct = TextEditingController(text: widget.products.stockProduct);
  }

  Future submit() async {
    http.Response response = await http.post(Uri.http("192.168.1.16", "latihan_iii/editProduct.php"),
    body: {
      "namaProduct" : namaProduct.text,
      "hargaProduct" : hargaProduct.text,
      "stockProduct" : stockProduct.text,
      "id" : widget.products.id,
    });
    final message = json.encode(response.body);
        debugPrint(message.toString());
        debugPrint(response.body.toString());
        debugPrint(response.headers.toString());
        print(response.statusCode.toString());
    check();
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setUp();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  nameProductForm(){
    return TextFormField(
      controller: namaProduct,
      decoration: InputDecoration(
        labelText: "Nama Product",
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        hintText: "Nama Product Toko",
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(1.05),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (value){
        if (value!.isEmpty){
          return "Tolong jangan sampai kosong input ini";
        }else{
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  priceProductForm(){
    return TextFormField(
      controller: hargaProduct,
      decoration: InputDecoration(
        labelText: "Price Product",
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        hintText: "Harga Product Toko",
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(1.05),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value){
        if (value!.isEmpty){
          return "Tolong jangan sampai kosong input ini";
        }else{
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  stockProductForm(){
    return TextFormField(
      controller: stockProduct,
      decoration: InputDecoration(
        labelText: "Stocck Product",
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        hintText: "Stock Product Toko",
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(1.05),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value){
        if (value!.isEmpty){
          return "Tolong jangan sampai kosong input ini";
        }else{
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _EditProduct(){
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: nameProductForm(),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: priceProductForm(),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: stockProductForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edited Form Product",
        style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18)
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: (){
              submit();
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightBlue,
      body: _EditProduct(),
    );
  }
}
