import 'package:app/src/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text('Tela carrinho'), centerTitle: true),
      body: _buildBody(cart, context),
    );
  }

  Widget _buildBody(CartViewModel cart, BuildContext context) {
    if (cart.items.isEmpty) {
      return Center(
        child: Text(
          'Carrinho Vázio',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return ListTile(
                leading: Image.network(
                  item.product.urlImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(item.product.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preço Unitário: R\$ ${item.product.uniPrice.toStringAsFixed(2)}',
                    ),
                    Text('Quantidade: ${item.quantity}'),
                    Text(
                      'Subtotal: ${item.subtotal.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () async {
                        try {
                          await cart.removeFromCart(item.product);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$e'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cart.addToCart(item.product, context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Resumo do pedido',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Total de itens: ${cart.totalItems}'),
              Text('Total: R\$ ${cart.total.toStringAsFixed(2)}'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await cart.checkout();
                    Navigator.pushNamed(context, '/checkout');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$e'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text('Finalizar pedido'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
