import 'package:flutter/material.dart';
import '../../../models/item_controle.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';

class ControleWidget extends StatelessWidget {
   const ControleWidget({required this.itemControle,Key? key}) : super(key: key);

   final ItemControle itemControle;

  @override
  Widget build(BuildContext context) {

    final product = context.watch<Product?>();

    final selected = itemControle == product?.selectedControle;

    Color color;
    if(!itemControle.hasStock){
      color = Colors.red.withAlpha(50);
    }
    else if(selected){
      color = Theme.of(context).primaryColor;
    }else{
      color = Colors.grey;
    }


    return GestureDetector(
      onTap: (){
        if(itemControle.hasStock){
          product?.selectedControle = itemControle;
       }
        return;

      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
           //color: !itemControle.hasStock ? Colors.red.withAlpha(50) : Colors.grey
              color: color,

          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                color: color,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                itemControle.name!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'R\$ ${itemControle.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                ),

              )
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Qtd: ${itemControle.stock.toStringAsFixed(2)}',
                  style: TextStyle(
                    color:color,
                  ),

                )
            )
          ],
        ),
      ),
    );
  }
}
