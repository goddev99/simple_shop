

import 'package:flutter/material.dart';
import 'package:simple_shop/helpers/validators.dart';
import 'package:simple_shop/providers/user_manager.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   final User user = User(server: '', password: '', email: '', name: '', confirmPassword: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Servidor'),
                      enabled: !userManager.loading,
                      validator: (server){

                        if(server!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      onSaved: (server) => user.server = server!,

                    ),

                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (name){
                        if(name!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if(name.trim().split(' ').length <= 1) {
                          return 'Preencha seu Nome completo';
                        }
                        return null;

                      },
                      onSaved: (name) => user.name = name!,

                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      validator: (email){
                        if(email!.isEmpty){
                          return 'Campo obrigatório';
                        }else if(!emailValid(email)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      onSaved: (email) => user.email = email!,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass){

                        if(pass!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if(pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.password = pass!,

                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Repita a Senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass){

                        if(pass!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if(pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass!,
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                      onPressed: userManager.loading  ? null : (){
                        if(formKey.currentState?.validate() == true){
                          formKey.currentState?.save();

                          if(user.password != user.confirmPassword){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Senhas não coincidem!'),
                                  backgroundColor: Colors.red,
                                )
                            );
                            return;
                          }
                          userManager.signUp(
                              user: user,
                              onFail: (e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Falha ao cadastrar'),
                                      backgroundColor: Colors.red,
                                    )
                                );
                              },
                              onSuccess: (){
                                Navigator.of(context).pushNamed('/home');
                              }
                          );
                        }
                      },

                        style: ElevatedButton.styleFrom(
                          primary:Theme.of(context).primaryColor,
                        ), child: userManager.loading ?  const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ) : const Text('CRIAR CONTA',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      )
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}