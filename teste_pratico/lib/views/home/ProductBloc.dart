import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:teste_pratico/entities/ProductsEntity.dart';
import 'package:teste_pratico/repositories/ProductRepository.dart';
import 'package:teste_pratico/views/login/loginview.dart';


abstract class IProductViewBloc {
  Stream<List<ProductEntity>> get productsStream;
  void fetchProducts();
  void logout(BuildContext context);
}

class ProductViewBloc extends BlocBase implements IProductViewBloc {
  final IProductRepository _productRepository;
  final StreamController<List<ProductEntity>> _productsController = StreamController<List<ProductEntity>>.broadcast();

  ProductViewBloc(this._productRepository);

  @override
  Stream<List<ProductEntity>> get productsStream => _productsController.stream;

  @override
  void fetchProducts() async {
    try {
      List<ProductEntity> products = await _productRepository.getProducts();
      _productsController.sink.add(products);
    } catch (e) {
      _productsController.sink.addError('Failed to fetch products');
    }
  }

  @override
  void logout(BuildContext context){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
  }

  @override
  void dispose() {
    _productsController.close();
    super.dispose();
  }
}
