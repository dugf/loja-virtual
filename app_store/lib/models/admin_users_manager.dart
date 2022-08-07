import 'package:app_store/datas/user_commom.dart';
import 'package:app_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

class AdminUsersManager extends Model {
  List<UserCommom> users = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserModel userModel) {
    if (userModel.adminEnabled!) {
      listenToUsers();
    }
  }

  void listenToUsers() {
    firestore.collection('users').get().then((snapshot) {
      users = snapshot.docs.map((e) => UserCommom.fromDoc(e)).toList();
      users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name!).toList();
}
