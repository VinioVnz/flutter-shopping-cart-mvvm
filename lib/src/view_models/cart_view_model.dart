import 'package:app/src/models/cart.dart';
import 'package:app/src/models/cart_item.dart';
import 'package:app/src/models/product.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final Cart _cart = Cart();

  List<CartItem> get items => _cart.items;
  double get total => _cart.total;
  int get totalItems => _cart.totalItems;

  void addToCart(Product product) {
    final index = _cart.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) {
      //produto n esta no carrinho
      _cart.items.add(CartItem(product: product, quantity: 1));
    } else {
      //produto esta no carrinho
      _cart.items[index].quantity++;
    }
    /*   print('Items do cart:');
    for(var item in items){
      print(item.product.name);
      print(item.quantity);
    } */
    notifyListeners();
  }

  void removeFromCart(Product product) {
    final index = _cart.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final item = _cart.items[index];

      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _cart.items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.items.clear();
    notifyListeners();
  }

  int checkQuantity(Product product) {
    final item = items.firstWhere(
      (i) => i.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    return item.quantity;
  }
}
