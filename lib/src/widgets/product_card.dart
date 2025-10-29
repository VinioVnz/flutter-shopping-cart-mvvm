import 'package:app/src/colors/cores.dart';
import 'package:app/src/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  Product product;
  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            ElevatedButton.icon(
              onPressed: () {
                //logica pra add ao carrinho
              },
              style: ElevatedButton.styleFrom(
                iconColor: Cores().mainColor,
                foregroundColor: Colors.black
              ),
              icon: Icon(Icons.shopping_cart),
              label: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
