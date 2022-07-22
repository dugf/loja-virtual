import 'package:app_store/datas/cart_product.dart';
import 'package:app_store/datas/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartProduct? cartProduct;

  const CartTile({Key? key, this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? _buildContent() {
      return Row(
        children: [
          SizedBox(
            width: 120,
            child: Image.network(cartProduct?.productData?.images?[0]),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    cartProduct?.productData?.title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    'Tamanho: ${cartProduct?.size}',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ ${cartProduct?.productData?.price?.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.remove)),
                      Text(cartProduct!.quantity!.toStringAsFixed(2)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Remove',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct?.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(cartProduct?.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct?.productData =
                      ProductData.fromDocument(snapshot.data!);
                  return _buildContent()!;
                } else {
                  return Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}
