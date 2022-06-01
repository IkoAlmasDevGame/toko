import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model.dart';

class Details extends StatefulWidget {
  Product product;
  Details({required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([]);
  }

  Widget detailsProduct(){
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.height - 75,
        height: MediaQuery.of(context).size.width + 181,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          backgroundBlendMode: BlendMode.difference,
          border: Border.all(width: 1.11, color: Colors.blueGrey, style: BorderStyle.solid),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Nama Product : ${widget.product.namaProduct.toString()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Harga Product : ${widget.product.hargaProduct.toString()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Stock Product : ${widget.product.stockProduct.toString()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("ID Product : ${widget.product.id.toString()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product Toko"),
        centerTitle: true,
      ),
      body: detailsProduct(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: TextButton(
          child: Text("Buying Product", style: TextStyle(color: Colors.white),),
          onPressed: (){
            print("Not Buying Sell Product : ${widget.product.namaProduct}");
          },
        ),
      ),
    );
  }
}
