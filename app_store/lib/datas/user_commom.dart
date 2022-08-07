import 'package:cloud_firestore/cloud_firestore.dart';

class UserCommom {
  UserCommom({
    this.email,
    this.address,
    this.name,
    this.id,
  });

  String? email;
  String? address;
  String? name;
  String? id;

  UserCommom.fromDoc(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.get('name');
    email = documentSnapshot.get('email');
    address = documentSnapshot.get('address');
  }
}
