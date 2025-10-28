import 'package:app/src/colors/cores.dart';
import 'package:app/src/views/cart_view.dart';
import 'package:app/src/views/catalog_view.dart';
import 'package:app/src/views/checkout_view.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Carrinho de Compras',
      debugShowCheckedModeBanner: false,
      initialRoute: '/catalog',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Cores().mainColor,
          foregroundColor: Cores().foregroundColor
        )
      ),
      routes: {
        '/catalog' : (context) => const CatalogView(),
        '/cart' : (context) => const CartView(),
        '/checkout' : (context) => const CheckoutView()
      },
    );
  }
}