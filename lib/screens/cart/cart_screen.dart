import 'package:flutter/material.dart';
import 'package:simple_shop/providers/product_manager.dart';
import 'package:simple_shop/screens/cart/components/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (_, cartManager, __){
          return Column(
            children: cartManager.cartList.map(
                    (cartProduct) => CartTile(cartProduct)
            ).toList(),
          );
        }
      ),
    );
  }
}
