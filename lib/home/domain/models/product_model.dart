import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final List<String> image;
  final double price;
  final String description;

  const ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  const ProductModel.initial()
      : id = '',
        name = '',
        image = const [],
        price = 0.0,
        description = '';

  ProductModel modify(
      {String? id,
      String? name,
      List<String>? image,
      double? price,
      String? description}) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, name, image, price, description];
}
