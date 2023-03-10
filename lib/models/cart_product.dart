
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:simple_shop/models/product.dart';
import 'package:simple_shop/repositories/products_repository.dart';

import '../providers/product_manager.dart';
import 'item_controle.dart';

class CartProduct extends ChangeNotifier {



  CartProduct.fromProduct(this.product, this.quantity){
    codprod = product?.codprod as int;
    quantity = quantity;
    controle = product?.selectedControle?.name as String;

  }

  ProductManager? productManager;


  CartProduct.fromJson(json){
    codprod = json['codprod'] as int;
    quantity = json['quantity'] as int;
    controle = json['controle'] as String;

   print('arquivo json ${codprod}');
  //product == Product.fromJson(json);
  //  (json['controle'] as List<dynamic>).map((controles) => ItemControle.fromJson(controles as Map<String, dynamic>) ).toList();

   ProductsRepository.cartProduct(codprod).then(
     //this part I want load information about product from my backend
           (value) => product = Product.fromJsonCart(value)
   );

  //  product = (json.decode(response)).map((i) => CartProduct.fromJson(i)).toList();
   print(product?.descrprod);
    //product = response as Product?;

   // print(product!.codprod);
  }




  int codprod = 0;
  int quantity = 0;
  String controle = '';

  Product? product;


  ItemControle? get itemControle{
    if(product == null){
      return null;
    }else{
      return product!.findControle(controle);
    }
  }

  num get unitPrice{
    if(product == null) return 0;
    return itemControle?.price ?? 0;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codprod'] = codprod;
    data['quantity'] = quantity;
    data['controle'] = controle;
    return data;
  }

}
