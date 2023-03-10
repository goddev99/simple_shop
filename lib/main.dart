import 'package:flutter/material.dart';
import 'package:simple_shop/providers/cart_manager.dart';
import 'package:simple_shop/screens/base/base_screen.dart';
import 'package:simple_shop/screens/cart/cart_screen.dart';
import 'package:simple_shop/screens/login/login_screen.dart';
import 'package:simple_shop/screens/product/product_screen.dart';

import 'package:simple_shop/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';


import 'models/product.dart';
import 'providers/product_manager.dart';
import 'providers/user_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserManager(),
            lazy: false,//para instanciar usuario ao abrir usuario
          ),

/*
          ChangeNotifierProvider(
            create: (_) => ProductManager(),
            lazy: false,
          ),
*/



          ProxyProvider<UserManager, CartManager?>(
            create: (_) => CartManager(),
            lazy: false,
            update: (_,userManager, cartManager) =>
            cartManager?..updateUser(userManager),
          ),
          ProxyProvider<UserManager, ProductManager?>(
            create: (_) => ProductManager(),
            lazy: false,
            update: (_,userManager, productManager) =>
            productManager?..updateProduct(userManager),
          )

        ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.blue,
          appBarTheme: const AppBarTheme(
              elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => const CartScreen()
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen()
              );
          }
        },
      ),
    );
  }
}
