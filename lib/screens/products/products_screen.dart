import 'package:flutter/material.dart';
import 'package:simple_shop/common/custom_drawer/custom_drawer.dart';
import 'package:simple_shop/providers/product_manager.dart';
import 'package:simple_shop/screens/products/components/product_list_tile.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __){
            if(productManager.search.isEmpty){
              return const Text('Produtos');
            } else {
              return LayoutBuilder(
                builder: (_, constraints){


                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(context: context,
                          builder: (_) => SearchDialog(productManager.search));
                      if(search != null){
                        productManager.search = search;
                      }
                    },
                    child: SizedBox(
                        width: constraints.biggest.width,
                        child: Text(
                          productManager.search,
                          textAlign: TextAlign.center,
                        )
                    ),
                  );

                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        final search = await showDialog<String>(context: context,
                            builder: (_) => SearchDialog(
                                productManager.search
                            ));
                        if(search != null){
                          productManager.search = search;
                        }
                      },
                    ),IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () async {
                        Navigator.of(context).pushNamed('/cart');
                      },
                    ),
                  ],
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){

          final filteredProducts = productManager.filteredProducts;


          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: filteredProducts.length,
              itemBuilder: (_, index){
                return ProductListTile(filteredProducts[index]);

              }

          );

        },

      ),
    );
  }
}