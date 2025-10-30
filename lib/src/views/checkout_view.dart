import 'package:app/src/colors/cores.dart';
import 'package:app/src/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Cores().mainColor,
        centerTitle: true,
      ),
      body: _buildBody(cart, context),
    );
  }

  Widget _buildBody(CartViewModel cart, BuildContext context) {
    double total = 0;
    double frete = 20;
    total = cart.total + frete;
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
                    Text(
                      'Subtotal: ${item.subtotal.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                'Resumo do Pedido:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Subtotal: R\$ ${cart.total.toStringAsFixed(2)}'),
              Text('Frete: R\$ ${frete.toStringAsFixed(2)}'),
              Text(
                'Total: R\$ ${total.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              SizedBox(height: 16),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Cores().mainColor,
                  foregroundColor: Cores().foregroundColor,
                ),
                onPressed: () {
                  cart.clearCart();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/catalog',
                    (route) => false,
                  );
                },
                child: Text('Novo pedido'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
