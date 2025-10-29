import 'package:app/src/colors/cores.dart';
import 'package:app/src/models/product.dart';
import 'package:app/src/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  Product product;

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Image.network(product.urlImage, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'R\$ ${product.uniPrice.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            _button(cart, context),
          ],
        ),
      ),
    );
  }

  Widget _button(CartViewModel cart, BuildContext context) {
    final quant = cart.checkQuantity(product);

    if (quant == 0) {
      //botao de add
      return ElevatedButton(
        onPressed: () {
          cart.addToCart(product, context);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        child: Text('Adicionar ao carrinho', textAlign: TextAlign.center),
      );
    } else {
      //contador + -
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              try {
                await cart.removeFromCart(product);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$e'), duration: Duration(seconds: 2)),
                );
              }
            },
            icon: Icon(Icons.remove),
          ),
          Text(
            '$quant',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => cart.addToCart(product, context),
            icon: Icon(Icons.add),
          ),
        ],
      );
    }
  }
}
