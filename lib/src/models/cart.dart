import 'package:app/src/models/cart_item.dart';

class Cart {
  final List<CartItem> items = [];

  double get total {
    double sum = 0;
    for (var item in items) {
      sum += item.subtotal;
    }
    return sum;
  }

  int get totalItems {
    int count = 0;
    for (var item in items) {
      count += item.quantity;
    }
    return count;
  }
}
