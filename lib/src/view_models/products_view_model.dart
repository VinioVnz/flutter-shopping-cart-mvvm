import 'package:app/src/models/product.dart';
import 'package:app/src/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsViewModel extends ChangeNotifier{
  final ProductService _service = ProductService();

  List<Product> products = [];
  bool loading = false;

  Future<void> loadProducts() async {
    loading = true;
    notifyListeners();

    try {
      products = await _service.getAll();
    } catch (e) {
      products = []; //em caso de erro, retornara apenas uma lista vazia
      print('Erro: $e');
    }

    loading = false;
    notifyListeners();
  }

}