
import 'dart:convert';

import 'package:simple_shop/models/user.dart';
import 'package:dio/dio.dart';


import '../models/login.dart';
import '../utils/preferences.dart';

class LoginRepository {

  static Future<SignUp> signUp(server, name, email, password) async {
    try {
      var dio = Dio();
      var params = {
        "name": name,
        "email": email,
        "password": password,
      };


      dio.options.baseUrl = 'http://$server/api';

      var response = await dio.post('/app/signup', data: jsonEncode(params));

      var token =  response.data['access_token'];
      Preferences preferences = Preferences();
      preferences.setString('access_token',token);
      preferences.setString('url',server!);

      return SignUp.fromJson(response.data);
    } on DioError catch (error) {
      return Future.error(error.response?.data);
    }
  }

 static Future<User> auth() async {
    try {
      var dio = Dio();
      final Preferences preferences = Preferences();
      var token = await preferences.getString('access_token');
      var tokenAuth = 'Bearer $token';

      var server = await preferences.getString('url');


      dio.options.headers["Authorization"] = tokenAuth;
      dio.options.baseUrl = 'http://$server/api';
      var response = await dio.get('/app/user');

      return User.fromJson(response.data);
    } on DioError catch (error) {
      return Future.error(error.response?.data);
    }
  }




 static Future<User> logout() async {
   try {
     var dio = Dio();
     final Preferences preferences = Preferences();
     var token = await preferences.getString('access_token');
     var tokenAuth = 'Bearer $token';

     var server = await preferences.getString('url');

     dio.options.headers["Authorization"] = tokenAuth;
     dio.options.baseUrl = 'http://$server/api';

     var response = await dio.get('/app/logout');

     await preferences.clear();

     return User.fromJson(response.data);
   } on DioError catch (error) {
     return Future.error(error.response?.data);
   }
 }

}



