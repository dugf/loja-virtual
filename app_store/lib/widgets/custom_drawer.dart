import 'package:app_store/models/user_model.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController? pageController;

  const CustomDrawer({Key? key, this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 211, 118, 130), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Flutter's\nClothing",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Olá, ${!model.isLoggedIn()! ? '' : model.userData['name']}",
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  (!model.isLoggedIn()!)
                                      ? "Entre ou cadastre-se >"
                                      : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn()!) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  } else {
                                    model.signOut();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawerTile(
                  iconData: Icons.home,
                  text: "Início",
                  controller: pageController,
                  page: 0),
              DrawerTile(
                  iconData: Icons.list,
                  text: "Produtos",
                  controller: pageController,
                  page: 1),
              DrawerTile(
                  iconData: Icons.location_on,
                  text: "Lojas",
                  controller: pageController,
                  page: 2),
              DrawerTile(
                  iconData: Icons.playlist_add_check,
                  text: "Meus Pedidos",
                  controller: pageController,
                  page: 3),
            ],
          )
        ],
      ),
    );
  }
}
