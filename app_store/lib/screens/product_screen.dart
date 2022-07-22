import 'package:app_store/datas/cart_product.dart';
import 'package:app_store/datas/product_data.dart';
import 'package:app_store/models/cart_model.dart';
import 'package:app_store/models/user_model.dart';
import 'package:app_store/screens/cart_screen.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final ProductData? data;

  const ProductScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState(data);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData? data;
  String? size;
  int? current = 0;
  final CarouselController _carouselController = CarouselController();

  _ProductScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(data?.title ?? ''),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 1.0,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  },
                ),
                items: data?.images?.map((e) {
                  return Image.network(e, fit: BoxFit.cover);
                }).toList()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data!.images!.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  data?.title ?? '',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${data!.price!.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: data!.sizes!.map((s) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                color: s == size
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                width: 3.0),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: size != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()!) {
                              CartProduct cartProduct = CartProduct();

                              cartProduct.size = size;
                              cartProduct.quantity = 1;
                              cartProduct.pid = data?.id;
                              cartProduct.category = data?.category;

                              CartModel.of(context).addCartItem(cartProduct);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CartScreen()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()!
                          ? 'Adicionar ao Carrinho'
                          : 'Entre para comprar',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Descrição',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  data?.description ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
