import 'dart:async';
import 'dart:convert';
import 'package:simple_shop/models/product.dart';
import 'package:simple_shop/providers/user_manager.dart';
import 'package:simple_shop/repositories/products_repository.dart';

import '../models/cart_product.dart';
import '../models/user.dart';
import '../utils/preferences.dart';


class ProductManager  {


  final Preferences preferences = Preferences();
  /*
   ProductManager()  {
    loadAllProducts();
  }
*/

  User? user;
  List<CartProduct> cartList=[];
   void updateProduct(UserManager userManager ){
     user = userManager.user;
     print('usuario ${user?.name}');
     if(user != null){
       loadAllProducts();
     }
   }

   List<Product> filterProducts = [];

  String _search = '';
//TODO resolv this isue
  String get search => _search;
  set search(String value){
    _search = value;
  //  notifyListeners();
  }

  List<Product> allProducts = [];

  Future<void> loadAllProducts() async {
    try {
      final response = await ProductsRepository.loadStockProductByCodProdAll();
      allProducts = (response as List).map((x) => Product.fromJson(x)).toList();
      reloadAllCart();
      //   notifyListeners();
    } catch (error) {
      // print(error);
      return;
    }
  }

  Future<void> reloadAllCart() async {
    try {
      var cart = await preferences.getString('cart');
      print(["=====cart=====00:",cart]);
      print(["=====cart=====00:",json.encode(cart)]);
      print(["=====cart=====00:",json.decode(json.encode(cart))]);
      List<CartProduct> tmpItems=[];
      print(["==========00:",tmpItems]);
      tmpItems = (json.decode(cart)).map((i) => CartProduct.fromJson(i)).toList();
      print(["==========11:",tmpItems]);
      cartList.clear();
      for (var element in tmpItems) {
        print(["==========22:",element]);
        for(var elementProduct in allProducts ){
          if(element.codprod==elementProduct.codprod){
            cartList.add(CartProduct.fromJson({
              "codprod":element.codprod,
              "quantity":element.quantity,
              "controle":elementProduct.controle!.last.name
            }));
            break;
          }
        }
      }
      //allProducts = (response as List).map((x) => Product.fromJson(x)).toList();
      //   notifyListeners();
    } catch (error) {
      // print(error);
      return;
    }
  }

  void addToCart(Product product, int quantity) async {

    final cartProduct = CartProduct.fromProduct(product,quantity);
    cartList.add(cartProduct);
    //This part I save in shared_preferences my item from the cart
    await preferences.setString('cart',json.encode(cartList));
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    } else {
      loadAllProducts();
      filteredProducts.addAll(
          allProducts.where(
                  (product) => product.descrprod!.toLowerCase().contains(search.toLowerCase())
          )
      );
    }
    return filteredProducts;
  }




}