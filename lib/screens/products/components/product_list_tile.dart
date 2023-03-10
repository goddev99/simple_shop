import 'package:flutter/material.dart';
import 'package:simple_shop/models/product.dart';

import '../../../models/product.dart';

class ProductListTile extends StatelessWidget {

  const ProductListTile(this.product,{super.key});

  final Product product;


  @override
  Widget build(BuildContext context) {

    var count = product.controle?.map((c) => c.price).length;

    return GestureDetector(
      onTap: (){
                Navigator.of(context).pushNamed('/product', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        ),

        child: Container(
          height: 140,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: AspectRatio(
                    aspectRatio:  1,
                    child: Image.network(product.endimagem!.first),
                     //   fit: BoxFit.cover,
                       // width: MediaQuery.of(context).size.width * 0.75),
                  )),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.descrprod!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                        children:[
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              'Código: ',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            product.codprod.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).primaryColor
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              '       Preço: ',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ]),
                    Row(
                        children:[

                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              'Local: ',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Flexible(child:
                          Text(
                            product.referencia!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).primaryColor
                            ),
                          )
                          ),
                        ]),


                    Visibility(
                      visible: (count! <= 1),
                      child: Row(
                          children:[
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                'Estoque: ',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              product.estoque.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).primaryColor
                              ),
                            ),
                          ]),
                    ),
                    /*
                    Row(
                        children:[
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              'Controle: ',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            product.controle.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).primaryColor
                            ),
                          ),
                        ]),

                     */
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}