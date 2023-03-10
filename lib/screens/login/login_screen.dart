import 'package:flutter/material.dart';
import 'package:simple_shop/helpers/validators.dart';
import 'package:simple_shop/models/user.dart';
import 'package:simple_shop/providers/product_manager.dart';
import 'package:simple_shop/providers/user_manager.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController serverController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(onPressed: (){
            Navigator.of(context).pushReplacementNamed('/signup');
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: const Text(
            'CRIAR CONTA',
            style: TextStyle(fontSize: 14),

          ),)

        ]
      ),
      body: Consumer<ProductManager>(
        builder: (_,productManager,child){
          return Center(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Consumer<UserManager>(
                    builder: (_, userManager, child){
                      return ListView(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        children: <Widget>[

                          TextFormField(
                            controller: serverController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(hintText: 'Servidor'),
                            keyboardType: TextInputType.url,
                            autocorrect: false,
                          ),

                          const SizedBox(height: 16,),

                          TextFormField(
                            controller: emailController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(hintText: 'E-mail'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (email){
                              if(!emailValid(email!)){
                                return 'E-mail inv??lido';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16,),

                          TextFormField(
                            controller: passController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(hintText: 'Senha'),
                            autocorrect: false,
                            obscureText: true,
                            validator: (pass){
                              if(pass == null || pass.length < 6) {
                                return 'Senha inv??lida';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: userManager.loading  ? null : (){
                                if(formKey.currentState?.validate() == true){

                                  userManager.singIn(
                                      user:
                                      User(
                                        server: serverController.text,
                                        email: emailController.text,
                                        password: passController.text,
                                        name: '', confirmPassword: '',
                                      ),  onFail: (e){

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          //content: Text('Falha ao entrar'),
                                          content: Text('Falha ao entrar: $e'),
                                          backgroundColor: Colors.red,
                                        )
                                    );
                                  },
                                      onSuccess: () async{
                                        Navigator.of(context).pop();
                                      }
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary:Theme.of(context).primaryColor,
                              ),
                              child: userManager.loading ?  const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ) :
                              const Text(
                                'Entrar',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),


                        ],
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){
                          //TODO: ACAO PARA RECUPERAR SENHA
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                            'Esqueci minha senha'
                        ),
                      ),
                    ),

                  ),

                ),
              )
          );
        },
      )
    );
  }
}

