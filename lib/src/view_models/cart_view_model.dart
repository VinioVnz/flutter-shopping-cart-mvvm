import 'package:app/src/models/cart.dart';
import 'package:app/src/models/cart_item.dart';
import 'package:app/src/models/product.dart';
import 'package:app/src/services/cart_api.dart';
import 'package:app/src/services/checkout_api.dart';
import 'package:app/src/utils/result.dart';
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
  Result<void> addToCart(Product product) {
    try {
      final index = _cart.items.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (index == -1) {
        _cart.items.add(CartItem(product: product, quantity: 1));
      } else {
        if (_cart.items[index].quantity < 10) {
          _cart.items[index].quantity++;
        } else {
          return Result.failure('Quantidade máxima de 10 itens por produto!');
        }
      }
      notifyListeners();
      return Result.success("Sucesso");
    } catch (e) {
      return Result.failure('$e');
    }
  }

  Future<Result<void>> removeFromCart(Product product) async {
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
      return Result.success("Sucesso");
    } catch (e) {
      return Result.failure('$e');
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

  Future<Result<void>> checkout() async {
    try {
      loading = true;
      notifyListeners();

      await _checkoutApi.checkout();
      return Result.success("Sucesso");
    } catch (e) {
      return Result.failure('$e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
