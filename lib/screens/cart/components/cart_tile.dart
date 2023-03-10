import 'package:flutter/material.dart';
import 'package:simple_shop/models/cart_product.dart';

class CartTile extends StatelessWidget {

  const CartTile(this.cartProduct,{super.key});


  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product!.endimagem!.first),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: <Widget>[
                  Text(
                    cartProduct.product!.descrprod!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Text(
                      'Controle: ${cartProduct.controle}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),

                  ),
                  Text(
                    'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  )

                ],

            ),
            ))
          ],
        ),
      )
    );
  }
}
