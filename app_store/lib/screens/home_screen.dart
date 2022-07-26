import 'package:app_store/tabs/home_tab.dart';
import 'package:app_store/tabs/orders_tab.dart';
import 'package:app_store/tabs/places_tab.dart';
import 'package:app_store/tabs/products_tab.dart';
import 'package:app_store/widgets/cart_buttom.dart';
import 'package:app_store/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: const HomeTab(),
          drawer: CustomDrawer(pageController: _pageController),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Produtos'),
            centerTitle: true,
          ),
          body: const ProductsTab(),
          drawer: CustomDrawer(pageController: _pageController),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Lojas'),
            centerTitle: true,
          ),
          body: const PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Meus Pedidos'),
            centerTitle: true,
          ),
          body: const OrdersTab(),
          drawer: CustomDrawer(pageController: _pageController),
        )
      ],
    );
  }
}
