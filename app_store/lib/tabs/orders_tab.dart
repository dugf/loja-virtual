import 'package:app_store/models/user_model.dart';
import 'package:app_store/screens/login_screen.dart';
import 'package:app_store/tiles/order_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersTabs extends StatelessWidget {
  const OrdersTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()!) {
      String uid = UserModel.of(context).firebaseUser!.user!.uid;

      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('orders')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data!.docs
                  .map((doc) => OrderTile(orderId: doc.id))
                  .toList(),
            );
          }
        },
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'Faça o login para acompanhar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
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
    }
  }
}
