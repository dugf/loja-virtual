import 'package:app_store/models/cart_model.dart';
import 'package:app_store/models/user_model.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/screens/order_screen.dart';
import 'package:app_store/tiles/cart_tile.dart';
import 'package:app_store/widgets/cart_price.dart';
import 'package:app_store/widgets/discount_card.dart';
import 'package:app_store/widgets/ship_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Meu Carrinho"),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              alignment: Alignment.center,
              child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
                  int p = model.products.length;
                  return Text(
                    '$p ${p == 1 ? 'ITEM' : 'ITENS'}',
                    style: const TextStyle(fontSize: 17.0),
                  );
                },
              ),
            )
          ],
        ),
        body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            if (model.isLoading && UserModel.of(context).isLoggedIn()!) {
              return const Center(child: CircularProgressIndicator());
            } else if (!UserModel.of(context).isLoggedIn()!) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_outlined,
                      size: 80.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Entrar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              );
            } else if (model.products.isEmpty) {
              return const Center(
                child: Text('Nenhum produto no carrinho',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              );
            } else {
              return ListView(
                children: [
                  Column(
                    children: model.products.map((product) {
                      return CartTile(cartProduct: product);
                    }).toList(),
                  ),
                  const DiscountCard(),
                  const ShipCard(),
                  CartPrice(
                    buy: () async {
                      final navigator = Navigator.of(context);
                      String? orderId = await model.finishOrder();
                      if (orderId != null) {
                        navigator.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(
                              orderId: orderId,
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
