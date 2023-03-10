import 'package:flutter/material.dart';
import 'package:simple_shop/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:simple_shop/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/login_repository.dart';


class UserManager extends ChangeNotifier {

  UserManager() {
    loadCurrentUser();
  }


  //SecureStorage
  final Preferences preferences = Preferences();

  bool _loading = false;

  User? user;

  bool get loading => _loading;

  bool get isLoggedIn => user != null;








  Future<void> singIn({required User user, required Function onFail, required Function onSuccess}) async {
    loading = true;
    try {
      var dio = Dio();

      //Teste para aguardar execucao
      //await Future.delayed(Duration(seconds: 4));

      SharedPreferences instance = await SharedPreferences.getInstance();
      await instance.clear();

      String? server = user.server;
      String? email = user.email;
      String? password = user.password;

      final auth = 'Basic ${base64Encode(utf8.encode('$email:$password'))}';
      dio.options.headers["authorization"] = auth;
      dio.options.baseUrl = 'http://$server/api';
      var response = await dio.post('/app/login');


      var token =  response.data['access_token'];

      Preferences preferences = Preferences();
      preferences.setString('access_token',token);
      preferences.setString('url',server!);

      await loadCurrentUser();
      onSuccess();

    } on DioError catch (error) {
      onFail(error.response?.data);
    }
    loading = false;
  }
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  Future<void> signUp({required User user, required Function onFail, required Function onSuccess}) async {
    loading = true;
    try {
      await LoginRepository.signUp(user.server, user.name, user.email, user.password);

      this.user = user;
      onSuccess();
    } catch (e) {
      onFail(e);
    }
    loading = false;
  }


  Future<void> signOut() async {
    await LoginRepository.logout();
    preferences.clear();
    user = null;
    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    try {
      var userAuth = await preferences.containsKey('access_token');
      if (userAuth == true) {
        final currentUser = await LoginRepository.auth();

        user = currentUser;
        notifyListeners();
      }else{
        //print('Nao encontrou nada');
      }
    } on DioError catch (error) {
      return Future.error(error.response?.data);
    }
  }






}