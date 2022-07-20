import 'package:app_store/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _namedController = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Criar Conta'),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: ((context, child, model) {
            if (model.isLoading!) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    TextFormField(
                      controller: _namedController,
                      decoration:
                          const InputDecoration(hintText: "Nome Completo"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Nome inválido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(hintText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text!.isEmpty || !text.contains('@')) {
                          return 'E-mail inválido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passController,
                      validator: (text) {
                        if (text!.isEmpty || text.length < 6) {
                          return "Senha inválido!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Senha"),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _addressController,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Endereço inválido!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Endereço"),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 44.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> userData = {
                              'name': _namedController.text,
                              'email': _emailController.text,
                              'address': _addressController.text,
                            };

                            model.signUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: const Text('Usuário criado com sucesso'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 2))
        .then((_) => Navigator.of(context).pop());
  }

  void _onFail() {
    _scaffoldKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Falha ao criar usuário!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
