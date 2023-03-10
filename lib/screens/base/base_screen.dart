import 'package:flutter/material.dart';
import 'package:simple_shop/common/custom_drawer/custom_drawer.dart';
import 'package:simple_shop/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/page_manager.dart';
import '../../providers/product_manager.dart';
import '../../providers/user_manager.dart';


class BaseScreen extends StatelessWidget {

  BaseScreen({super.key});

  final PageController pageController = PageController();

  final scrollController = ScrollController(initialScrollOffset: 50.0);
  
  
  @override

  Widget build(BuildContext context) {

    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Scaffold(
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home'),
                ),
              ),


              if(userManager.isLoggedIn)

                ...[
               //   ConsultaPreco(),
                //  ConferenciaColetorScreen(),
                 // ConferenciaNfeScreen(),
                  const ProductsScreen(),
                ]


            ],
          );
        },
      ),
    );
  }
}

class LoadAllDataAfterLogin {
  late ProductManager productManager;
  Future<void> myAsyncMethod(BuildContext context) async {
    await productManager.loadAllProducts();
  }
}