import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:toko/Home.dart';
import 'package:toko/model.dart';

class AddProducts extends StatefulWidget {
  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final keyForm = GlobalKey<FormState>();

  final TextEditingController namaProductController = TextEditingController();
  final TextEditingController hargaProductController = TextEditingController();
  final TextEditingController stockProductController = TextEditingController();

  FormSaver(){
    final key = keyForm.currentState;
    if (key!.validate()){
      key.save();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>Home()));
    }
  }

  Future fetchSaveForm() async {
    var data = {"namaProduct":namaProductController.text, "hargaProduct":hargaProductController.text, "stockProduct":stockProductController.text};
    http.Response response = await http.post(Uri.http("192.168.1.16", "latihan_iii/addProduct.php"),
    body: data, headers: {"Accept" : "application/json"});
    final message = json.decode(response.body);
    if (message == "data berhasil ditambahkan") {
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toInt().toString());
      debugPrint(response.headers.toString());
      print(message.toString());
    }
    FormSaver();
    return jsonEncode(response.body);
  }

  nameProductForm(){
    return TextFormField(
      controller: namaProductController,
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
      controller: hargaProductController,
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
      controller: stockProductController,
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

  Widget _AddCreateProduct(){
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        child: Form(
          key: keyForm,
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
        title: Text("Form Product Toko",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check, size: 18),
            onPressed: (){
              fetchSaveForm();
              },
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(152, 88, 100, 1),
      body: _AddCreateProduct(),
    );
  }
}

