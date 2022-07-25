import 'package:app_store/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: const Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        leading:
            Icon(Icons.card_giftcard, color: Theme.of(context).primaryColor),
        trailing: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Digite seu cupom'),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text) {
                if (text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Insira o cupom!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  FirebaseFirestore.instance
                      .collection('coupons')
                      .doc(text)
                      .get()
                      .then((docSnap) {
                    if (docSnap.data() != null) {
                      CartModel.of(context)
                          .setCoupon(text, docSnap.get('percent'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Desconto de ${docSnap.get('percent')}% aplicado'),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    } else {
                      CartModel.of(context).setCoupon(null, 0);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cupom não existente!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
