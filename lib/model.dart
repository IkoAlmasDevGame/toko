// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

class Product {
  Product({
    required this.id,
    required this.namaProduct,
    required this.hargaProduct,
    required this.stockProduct,
  });

  String id;
  String namaProduct;
  String hargaProduct;
  String stockProduct;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      namaProduct: json["namaProduct"],
      hargaProduct: json["hargaProduct"],
      stockProduct: json["stockProduct"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
    "namaProduct": namaProduct,
    "hargaProduct": hargaProduct,
    "stockProduct": stockProduct,
  };
}
