import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toko/DetailsProduct.dart';
import 'package:toko/FormCreate.dart';
import 'package:toko/FormEdited.dart';
import 'package:toko/model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> product;
  bool loading = false;

  Future<void> resfreshProducts() async {
    setState(() {
      product = fetchDataProduct();
    });
  }

  _delete(String id) async {
    http.Response response = await http.post(Uri.parse("http://192.168.1.16/latihan_iii/deleteProduct.php"),
        body: {
          "id": id,
        });
    final message = jsonDecode(response.body);
    if (message == "Data berhasil dihapus") {
      setState(() {
        resfreshProducts();
      });
    } else {
      print('Data tidak terhapus');
    }
    debugPrint("Response : " + response.body);
    debugPrint("Status Code : " + (response.statusCode).toString());
    debugPrint("Headers : " + (response.headers.toString()));
    return product;
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    product = fetchDataProduct();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    super.dispose();
  }

  final list = [];
  Future <List<Product>> fetchDataProduct() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse("http://192.168.1.16/latihan_iii/readProduct.php"));
    final item = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> products = item.map<Product>((json){
      return Product.fromJson(json);
    }).toList();
    setState(() {
      loading = false;
    });
    return products;
  }

  Widget _BuildProduct(){
    return RefreshIndicator(
      onRefresh: resfreshProducts,
      child: Container(
        child: FutureBuilder(
          future: fetchDataProduct(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return ListView.builder(
                itemCount: asyncSnapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  Product products = asyncSnapshot.data![index];
                  return Card(
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ID Product : ${products.id.toString()}",
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                            textDirection: TextDirection.ltr,),
                          Text("Nama Product : ${products.namaProduct
                              .toString()}", style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                          Text("Harga Product : ${products.hargaProduct
                              .toString()}", style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                          Text("Stock Product : ${products.stockProduct
                              .toString()}", style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                    Icons.edit, size: 20, color: Colors.grey),
                                onPressed: () {
                                  Navigator.pushReplacement(context, new MaterialPageRoute(
                                          builder: (context) => EditedProduct(products: products, resfreshProducts: resfreshProducts)));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, size: 20,
                                    color: Colors.blueGrey),
                                onPressed: () {
                                  _delete(products.id.toString());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(product: products)));
                      },
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.white, color: Colors.green));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toko Test App", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 19, color: Colors.black38),
            onPressed: (){
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>AddProducts()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightBlue,
      body: _BuildProduct(),
    );
  }
}
