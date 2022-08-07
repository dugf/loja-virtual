import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:app_store/models/admin_users_manager.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AdminUsersManager>(
      builder: (_, __, adminUsersManager) {
        if (adminUsersManager != null) {
          adminUsersManager.listenToUsers();

          return AlphabetScrollView(
            list: adminUsersManager.names.map((e) => AlphaModel(e)).toList(),
            itemExtent: 50,
            itemBuilder: (_, k, id) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ListTile(
                  title: Text(id),
                  subtitle: Text(adminUsersManager.users[k].email!),
                ),
              );
            },
            selectedTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
            unselectedTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          );
        } else {
          return const Center(
            child: Text('Usuários não encontrados!'),
          );
        }
      },
    );
  }
}
