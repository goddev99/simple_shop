import 'dart:convert';

import 'package:simple_shop/models/cart_product.dart';
import 'package:simple_shop/models/product.dart';
import 'package:simple_shop/models/user.dart';

import 'user_manager.dart';
import '../utils/preferences.dart';

class CartManager{

  final Preferences preferences = Preferences();

  List<CartProduct> items = [];

  User? user;
  Product? product;

  void updateUser(UserManager userManager ){


    user = userManager.user;
    items.clear();
    if(user != null){
      //this parte I check if User is logged and call to load cart save in shared_preferences
      _loadCartItems();
    }
  }



  void addToCart(Product product, int quantity) async {

    final cartProduct = CartProduct.fromProduct(product,quantity);
    items.add(cartProduct);

    //This part I save in shared_preferences my item from the cart
    await preferences.setString('cart',json.encode(items));

  }

  Future<void> _loadCartItems() async{
//TODO

    var cart = await preferences.getString('cart');

    print(cart);
    //When load my app. I clear the items and load from my shared_preferences
    items = (json.decode(cart)).map((i) => CartProduct.fromJson(i)).toList();


  }


}