import 'package:flutter/material.dart';
import 'package:simple_shop/common/custom_drawer/custom_drawer.header.dart';
import 'package:simple_shop/common/custom_drawer/drawer_tile.dart';
import 'package:provider/provider.dart';

import '../../providers/user_manager.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
          ListView(
            children:  <Widget>[
              const

              CustomDrawerHeader(),
              const Divider(),
              const DrawerTile(
                iconData: Icons.home,
                title: 'Home',
                page: 0,
              ),


              Consumer<UserManager>(
                  builder: (_, userManager, __) {
                              if (userManager.isLoggedIn) {
                      return Column(
                        children: const <Widget>[

                          DrawerTile(
                            iconData: Icons.list,
                            title: 'Consulta Produtos',
                            page: 1,
                          ),
/*
                          DrawerTile(
                            iconData: Icons.list,
                            title: 'Fila de Conferência',
                            page: 2,
                          ),
*/

                        ],
                      );
                    }else {
                      return Container();
                    }

                  }),

              /*
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Meus Pedidos',
                page: 2,
              ),

               */
              /*
              DrawerTile(
                iconData: Icons.location_on,
                title: 'Lojas',
                page: 3,
              ),


               */

              /*
              DrawerTile(
                iconData: Icons.list,
                title: 'NFE',
                page: 5,
              ),

              DrawerTile(
                iconData: Icons.list,
                title: 'Produtos',
                page: 6,
              ),
*/
            ],
          ),
        ],
      ),
    );
  }
}
