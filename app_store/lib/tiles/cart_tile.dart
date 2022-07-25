import 'package:app_store/datas/cart_product.dart';
import 'package:app_store/datas/product_data.dart';
import 'package:app_store/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartTile extends StatefulWidget {
  final CartProduct? cartProduct;

  const CartTile({Key? key, this.cartProduct}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    Widget? _buildContent() {
      CartModel.of(context).updatePrices();
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 120,
            child: Image.network(
              widget.cartProduct?.productData?.images?[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.cartProduct?.productData?.title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    'Tamanho: ${widget.cartProduct?.size}',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ ${widget.cartProduct?.productData?.price?.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: widget.cartProduct!.quantity! > 1
                              ? () {
                                  CartModel.of(context)
                                      .decProduct(widget.cartProduct!);
                                }
                              : null,
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).primaryColor,
                          )),
                      Text(widget.cartProduct!.quantity!.toString()),
                      IconButton(
                          onPressed: () {
                            CartModel.of(context)
                                .incProduct(widget.cartProduct!);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          )),
                      TextButton(
                          onPressed: () {
                            CartModel.of(context)
                                .removeCartItem(widget.cartProduct!);
                          },
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
      child: widget.cartProduct?.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(widget.cartProduct?.category)
                  .collection('items')
                  .doc(widget.cartProduct?.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  widget.cartProduct?.productData =
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
