import 'package:app_store/datas/product_data.dart';
import 'package:app_store/tiles/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot? snapshot;

  const CategoryScreen({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(snapshot?.get("title")),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("products")
              .doc(snapshot?.reference.id)
              .collection("items")
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 0.65),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        type: "grid",
                        data: ProductData.fromDocument(
                            snapshot.data!.docs[index]),
                      );
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(4.0),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        type: "list",
                        data: ProductData.fromDocument(
                            snapshot.data!.docs[index]),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
