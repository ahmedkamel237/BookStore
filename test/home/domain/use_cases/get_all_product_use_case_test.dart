import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/home/domain/models/product_model.dart';
import 'package:store_app/home/domain/repository/home_repository.dart';
import 'package:store_app/home/domain/use_cases/get_all_product_use_case.dart';

class GetAllProductRepo extends Mock implements HomeRepository {}

void main() {
  late GetAllProductRepo repo;
  late GetAllProductUseCase getAllProductUseCase;

  setUp(() {
    repo = GetAllProductRepo();
    getAllProductUseCase = GetAllProductUseCase(homeRepository: repo);
  });

  final testProductList = [
    ProductModel.initial(),
    ProductModel.initial(),
    ProductModel.initial(),
    ProductModel.initial(),
  ];

  test("should return list of products", () async {
    // arrange
    /// any is a get random value from the type that you pass to it and when use named parameter and named in the function.
    when(() => repo.getAllProducts(any()))
        .thenAnswer((_) async => testProductList);

    // act
    final result = await getAllProductUseCase.execute("1");

    //assert

    expect(result, equals(testProductList));
    verify(() => repo.getAllProducts("1")).called(1);
    verifyNoMoreInteractions(repo);
  });
}
