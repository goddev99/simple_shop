import 'package:dio/dio.dart';
import 'package:simple_shop/models/cart_product.dart';
import '../models/product.dart';
import '../utils/preferences.dart';


class ProductsRepository {


  Product? product;

  static Future<void> loadStockProductByCodProdAll() async {
    try {
      var dio = Dio();
      final Preferences preferences = Preferences();
      var token = await preferences.getString('access_token');


      var url = await preferences.getString('url');
      var tokenAuth = 'Bearer $token';

      dio.options.headers["Authorization"] = tokenAuth;
      dio.options.baseUrl = 'http://$url/api';
      var response = await dio.get('/product/6754/stock/all');
      return response.data;


    } on DioError catch (error) {
      return Future.error(error.response?.data);
    }
  }

  static Future<Product> cartProduct(codprod) async {
    try {
      var dio = Dio();
      final Preferences preferences = Preferences();
      var token = await preferences.getString('access_token');


      var url = await preferences.getString('url');
      var tokenAuth = 'Bearer $token';

      dio.options.headers["Authorization"] = tokenAuth;
      dio.options.baseUrl = 'http://$url/api';
      var response = await dio.get('/product/$codprod/stock/all2');

      return response.data;


    } on DioError catch (error) {
      return Future.error(error.response?.data);
    }
  }


}



