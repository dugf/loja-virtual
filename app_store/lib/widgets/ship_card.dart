import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: const Text(
          'Calcular Frete',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: 'Digite seu CEP',
              ),
              initialValue: '',
              onFieldSubmitted: (text) {},
            ),
          ),
        ],
      ),
    );
  }
}
