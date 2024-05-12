import 'package:stor_app/home/domain/models/product_model.dart';
import 'package:stor_app/home/domain/repository/home_repository.dart';

class GetAllProductUseCase {
  final HomeRepository homeRepository;

  GetAllProductUseCase({required this.homeRepository});

  Future<List<ProductModel>> execute(String categoryId) async {
    final result = homeRepository.getAllProducts(categoryId);
    return result;
  }
}
