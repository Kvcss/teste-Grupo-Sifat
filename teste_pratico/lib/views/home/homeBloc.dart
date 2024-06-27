import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:teste_pratico/entities/ProductsEntity.dart';
import 'package:teste_pratico/repositories/ProductEntity.dart';

abstract class IProductViewBloc {
  Stream<List<ProductEntity>> get productsStream;
  void fetchProducts();
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
      print(e.toString());
      _productsController.sink.addError('Failed to fetch products');
    }
  }

  @override
  void dispose() {
    _productsController.close();
    super.dispose();
  }
}
