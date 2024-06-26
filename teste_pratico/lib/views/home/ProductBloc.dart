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
//Essa classe vai servir controlar o estado dos dados.
class ProductViewBloc extends BlocBase implements IProductViewBloc {
  final IProductRepository _productRepository;
  final StreamController<List<ProductEntity>> _productsController = StreamController<List<ProductEntity>>.broadcast();

  ProductViewBloc(this._productRepository);

  @override
  Stream<List<ProductEntity>> get productsStream => _productsController.stream;

  //Vai acessar o método que irá coletar os dados da api pública 
  @override
  void fetchProducts() async {
    try {
      List<ProductEntity> products = await _productRepository.getProducts();
      _productsController.sink.add(products);
    } catch (e) {
      _productsController.sink.addError('Failed to fetch products');
    }
  }

  //Redireciona o usuario de volta para a pagina de login
  @override
  void logout(BuildContext context){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
  }
  //Liberar a memória ocupada pelo controller 
  @override
  void dispose() {
    _productsController.close();
    super.dispose();
  }
}
