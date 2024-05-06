class ApiCategoryModel {
  ApiCategoryModel(this.name, this.image, this.id);

  factory ApiCategoryModel.fromJson(Map<String, dynamic> json) =>
      ApiCategoryModel(
        json['name'].toString(),
        json['image'].toString(),
        json['id'].toString(),
      );

  final String? name;
  final String? image;
  final String? id;
}
