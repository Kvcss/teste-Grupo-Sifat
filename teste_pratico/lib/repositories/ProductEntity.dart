import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:teste_pratico/entities/ProductsEntity.dart';

abstract class IProductRepository {
  Future<List<ProductEntity>> getProducts();
}

class ProductRepository implements IProductRepository {
  @override
  Future<List<ProductEntity>> getProducts() async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ProductEntity.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to fetch products');
    }
  }
}
