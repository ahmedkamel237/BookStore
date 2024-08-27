class ApiProductModel {
  final String? id;
  final String? name;
  final List<String>? image;
  final double? price;
  final String? description;


  factory ApiProductModel.fromJson(Map<String, dynamic> json) =>
      ApiProductModel(
        json['id'].toString(),
        json['name'].toString(),
        json['image'].toString().split(',').toList(),
        json['price'].toDouble(),
        json['description'].toString(),
      );

  ApiProductModel(this.id, this.name, this.image, this.price, this.description);


}