import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {
  const CategoriesModel({
    required this.id,
    required this.name,
    required this.image,
  });

  const CategoriesModel.initial() : this(id: '', name: '', image: '');

  CategoriesModel modify({String? id, String? name, String? image}) {
    return CategoriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  final String id;
  final String name;
  final String image;

  @override
  List<Object?> get props => [id, name, image];
}
