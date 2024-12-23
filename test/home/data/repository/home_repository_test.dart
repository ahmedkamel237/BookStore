import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/home/data/repository/home_repository_imp.dart';
import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/repository/home_repository.dart';

class MockHomeRepository extends Mock implements CollectionReference<Map<String, dynamic>> {}
void main (){
  late MockHomeRepository mockHomeRepository;
  late HomeRepository homeRepository;
  setUp((){
    mockHomeRepository = MockHomeRepository();
    homeRepository = HomeRepositoryImp(mockHomeRepository);
  });

  setUp((){
    group("getAllCategories", (){
      test("should return list of categories", () async {
        final testCategoryList = [
          CategoriesModel.initial(),
          CategoriesModel.initial(),
          CategoriesModel.initial(),
          CategoriesModel.initial(),
        ];

        //arrange
        when(() => mockHomeRepository.get()).thenAnswer((_) async {
          if (testCategoryList.isEmpty) {
            throw Exception('Error');
          }
          return  testCategoryList as Future<QuerySnapshot<Map<String, dynamic>>>;
        });

        //act
        final result = await homeRepository.getAllCategories();

        //assert
        expect(result, equals(testCategoryList));

        // verify that the repository was called once with the correct argument
        verify(() => mockHomeRepository.get()).called(1);
        verifyNoMoreInteractions(mockHomeRepository);
      });
    });
  });
}

