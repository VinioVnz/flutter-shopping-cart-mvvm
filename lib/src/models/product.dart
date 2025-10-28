class Product {
  final int id;
  final String name;
  final double uniPrice;
  final String urlImage;

  Product({
    required this.id,
    required this.name,
    required this.uniPrice,
    required this.urlImage,
  });

  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'], 
      name: json['title'], 
      uniPrice: json['price'].toDouble(), 
      urlImage: json['image']
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'title' : name,
      'price' : uniPrice,
      'image': urlImage
    };
  }
}
