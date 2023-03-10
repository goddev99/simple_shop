class ItemControle {


  ItemControle.fromJson(Map<String, dynamic> json,){
    name = json['name'] as String;
    price = json['price'] as num;
    stock = json['stock'] as int;
  }



  String? name;
   num  price = 0.0;
   int  stock = 0;


  bool get hasStock => stock > 0 ;

  @override
  String toString() {
    return 'ItemControle{name: $name, price: $price, stock: $stock}';
  }
}