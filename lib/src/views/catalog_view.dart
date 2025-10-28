import 'package:app/src/view_models/produtct_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProdutctViewModel()..loadProducts(),
      child: Consumer<ProdutctViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(title: Text('Catálogo')),
            body: _buildBody(viewModel),
          );
        },
      ),
    );
  }

  Widget _buildBody(ProdutctViewModel viewModel) {
    if (viewModel.loading) {
    return Center(child: CircularProgressIndicator());
  }
    return ListView.builder(
      itemBuilder: (context, index) {
        final product = viewModel.products[index];
        return ListTile(
          leading: Image.network(
            product.urlImage,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(product.name),
          subtitle: Text('R\$ ${product.uniPrice.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
