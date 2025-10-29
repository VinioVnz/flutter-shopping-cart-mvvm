import 'package:app/src/view_models/products_view_model.dart';
import 'package:app/src/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsViewModel()..loadProducts(),
      child: Consumer<ProductsViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(title: Text('Catálogo'), centerTitle: true,),
            body: _buildBody(viewModel),
          );
        },
      ),
    );
  }

  Widget _buildBody(ProductsViewModel viewModel) {
    if (viewModel.loading) {
    return Center(child: CircularProgressIndicator());
  }
  if(viewModel.products.isEmpty){
    return Center(child: Text('Nenhum produto encontrado'),);
  }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, //numero de colunas
      crossAxisSpacing: 16, 
      mainAxisSpacing: 16,
      childAspectRatio: 0.75,
    ), 
      itemCount: viewModel.products.length,
      itemBuilder: (context, index) {
        final product = viewModel.products[index];
        return ProductCard(product: product,);
      },
      );
  }
}
