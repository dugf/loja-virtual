import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String? orderId;

  const OrderTile({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(orderId!),
    );
  }
}
