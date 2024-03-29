import 'package:app_store/models/admin_users_manager.dart';
import 'package:app_store/models/cart_model.dart';
import 'package:app_store/models/user_model.dart';
import 'package:app_store/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<AdminUsersManager>(
            model: AdminUsersManager(),
            child: ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: "Flutter's Clothing",
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: const Color.fromARGB(255, 4, 125, 141)),
                debugShowCheckedModeBanner: false,
                home: const HomeScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
