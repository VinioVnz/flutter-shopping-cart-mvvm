class CartApi {
  Future<void> removeItem(int productId) async {
    await Future.delayed(Duration(seconds: 1));

    final random = DateTime.now().millisecondsSinceEpoch % 2;
    if (random == 0) {
      throw ('Erro ao remover item do carrinho');
    }
  }
}
