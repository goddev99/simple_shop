import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_shop/providers/user_manager.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_manager.dart';
import '../../models/product.dart';
import '../../models/cart_product.dart';
import '../../providers/product_manager.dart';
import '../cart/components/controle_widget.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen(this.product, {Key? key}) : super(key: key);

  final Product product;

  //Variaveis para criar carousel


  final CarouselController _controller = CarouselController();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {

  final TextEditingController _qtddialog = TextEditingController();

  late CartProduct cartProduct;

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
  final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Text(widget.product.descrprod!)),
            ],
          ),
         // centerTitle: true,
        ),
        body: ListView(
            children:  <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {

                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                carouselController: widget._controller,
                items: widget.product.endimagem!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin:  const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white
                        ),
                        child: Image.network(i),
                      );

                    },
                  );
                }//Slider Container properties
                ).toList(),

              ), Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.endimagem!.asMap().entries.map((index) {
                  return GestureDetector(
                      onTap: () => widget._controller.animateToPage(index.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black).withOpacity(_currentIndex == index.key ? 0.9 : 0.4),
                        ),
                      )
                  );
                }).toList(),
              ),

            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Descrição: ${widget.product.descdetail}',
                    style:  TextStyle(
                      color: Colors.grey[800],
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ), Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ 19.99',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Controle',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.product.controle!.map((s){

                        return ControleWidget(itemControle: s);

                      }).toList(),
                    ),
                  )
                ],
              ),
            ),const SizedBox(height: 20,),
              Consumer3<UserManager, Product,ProductManager>(
                  builder: (_, userManager, product,productManager, __){

                    return   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //  const SizedBox(height: 10,),
                        SizedBox(
                          width: 180,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: product.selectedControle?.name != null ? () {


                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Quantidade'),
                                    content: TextField(
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      controller: _qtddialog,
                                      decoration: const InputDecoration(
                                          hintText: "Digite a quantidade"),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('CANCEL'),
                                        onPressed: () {
                                          Navigator.pop(context);

                                        },
                                      ),
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () async {

                                          //TODO adicionar ao carrinho
                                         // print(userManager.user?.name);
                                         // print(product.selectedControle?.name);
                                         // print(_qtddialog.text);

                                          context.read<ProductManager>().addToCart(product,int.parse(_qtddialog.text));

                                          //cartManager.items.map((e) => e.quantity);


                                         // print( cartManager.items.map((e) => e.quantity));
                                          //print( cartManager.items.map((e) => e));
                                          Navigator.of(context).pushNamed('/cart');
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } : null,
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              fixedSize: const Size(300, 100),
                              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                            ),
                            child: Text(
                                product.selectedControle?.name != null ? 'Adicionar Carrinho':'Selecione Controle',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              )

            ]
        ),
      ),
    );
  }
}

