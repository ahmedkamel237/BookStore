import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/repository/home_repository.dart';
import 'package:store_app/home/domain/use_cases/get_all_categores_use_case.dart';

class MockTestRepository extends Mock implements HomeRepository {}

void main() {
  late MockTestRepository repository;
  late GetAllCategoriesUseCase getAllCategoriesUseCase;

  // Registers a function to be run before tests.
  // علشان اتاكد ان عند كل test هتاخد قيمه جديده
  setUp(
    () {
      repository = MockTestRepository();
      getAllCategoriesUseCase = GetAllCategoriesUseCase(repository);
    },
  );

  test(
    'should return list of categories',
    () async {
      final testCategoryList = [
        CategoriesModel.initial(),
        CategoriesModel.initial(),
        CategoriesModel.initial(),
        CategoriesModel.initial(),
      ];

      //arrange
      when(() => repository.getAllCategories()).thenAnswer((_) async {
        if (testCategoryList.isEmpty) {
          throw Exception('Error');
        }
        return testCategoryList;
      });

      //act
      final result = await getAllCategoriesUseCase.execute();

      //assert
      expect(result, equals(testCategoryList));

      // verify that the repository was called once with the correct argument
      verify(() => repository.getAllCategories()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
