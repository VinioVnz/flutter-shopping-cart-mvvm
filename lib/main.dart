import 'package:app/app.dart';
import 'package:app/src/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartViewModel(),
      child: const App(),
    ),
  );
}
