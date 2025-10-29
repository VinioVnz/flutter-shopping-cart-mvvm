import 'dart:convert';

import 'package:app/src/models/product.dart';
import 'package:http/http.dart' as http;
class ProductsApi {
  final String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getAll() async{
    final response = await http.get(Uri.parse(_baseUrl));

    if(response.statusCode != 200){
      throw Exception('Erro ao carregar produtos');
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Product.fromJson(json)).toList();
    
  }
}