import 'package:app/src/models/cart.dart';
import 'package:app/src/models/cart_item.dart';
import 'package:app/src/models/product.dart';
import 'package:app/src/services/cart_api.dart';
import 'package:app/src/services/checkout_api.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final Cart _cart = Cart();
  final CheckoutApi _checkoutApi = CheckoutApi();
  final CartApi _cartApi = CartApi();

  List<CartItem> get items => _cart.items;
  double get total => _cart.total;
  int get totalItems => _cart.totalItems;
  bool loading = false;
  String error = '';
  void addToCart(Product product, BuildContext context) {
    final index = _cart.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) {
      //produto n esta no carrinho
      _cart.items.add(CartItem(product: product, quantity: 1));
    } else {
      //produto esta no carrinho
      if (_cart.items[index].quantity < 10) {
        //logica da regra de negocio
        _cart.items[index].quantity++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Quantidade máxima de 10 itens por produto!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
    /*   print('Items do cart:');
    for(var item in items){
      print(item.product.name);
      print(item.quantity);
    } */
    notifyListeners();
  }

  Future<void> removeFromCart(Product product) async {
    try {
      await _cartApi.removeItem(product.id);

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
    } catch (e) {
      rethrow;
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

  Future<void> checkout() async {
    try {
      loading = true;
      notifyListeners();

      await _checkoutApi.checkout();
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
