import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/common/base/async.dart';
import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/models/product_model.dart';
import 'package:store_app/home/domain/use_cases/get_all_categores_use_case.dart';
import 'package:store_app/home/domain/use_cases/get_all_product_use_case.dart';
import 'package:store_app/home/ui/home_cubit.dart';
import 'package:store_app/home/ui/home_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockHomeGetCategories extends Mock implements GetAllCategoriesUseCase {}

class MockHomeGetProducts extends Mock implements GetAllProductUseCase {}

void main() {
  late GetAllCategoriesUseCase getAllCategories;
  late GetAllProductUseCase getAllProducts;
  late HomeCubit cubit;

  final tCategoriesList = [
    CategoriesModel.initial(),
  ];
  setUp(() {
    getAllCategories = MockHomeGetCategories();
    getAllProducts = MockHomeGetProducts();
    cubit = HomeCubit(getAllCategories, getAllProducts);
    // registerFallbackValue(cubit);
  });

  // after each test case close the cubit to avoid memory leak ✅
  tearDown(() {
    cubit.close();
  });

  test("every cubit", () {
    expect(cubit.state, HomeState.initial());
  });

  group("GetAllCategories", () {
    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when getAllProducts is called',
      build: () {
        when(() => getAllCategories.execute())
            .thenAnswer((_) async => tCategoriesList);
        return cubit;
      },
      act: (cubit) {
        return cubit.getAllCategories();
      },
      expect: () {
        return [
          HomeState(
            getAllCategory: Async.loading(),
            getAllProduct: Async.initial(),
            errorMessage: null,
          ),
          HomeState(
            getAllCategory: Async.success(tCategoriesList),
            getAllProduct: Async.initial(),
            errorMessage: null,
          ),
        ];
      },
      verify: (_) {
        verify(() => getAllCategories.execute()).called(1);
        verifyNoMoreInteractions(getAllCategories);
      },
    );
  });

  group("GetAllCategoriesFail", () {
    blocTest<HomeCubit, HomeState>(
      'emits [loading, error] when getAllProducts is called',
      build: () {
        when(() => getAllCategories.execute()).thenThrow("error");
        return cubit;
      },
      act: (cubit) {
        return cubit.getAllCategories();
      },
      expect: () {
        return [
          HomeState(
            getAllCategory: Async.loading(),
            getAllProduct: Async.initial(),
            errorMessage: null,
          ),
          HomeState(
            getAllCategory: Async.failure(Failure(message: "error")),
            getAllProduct: Async.initial(),
            errorMessage: null,
          ),
        ];
      },
      verify: (_) {
        verify(() => getAllCategories.execute()).called(1);
        verifyNoMoreInteractions(getAllCategories);
      },
    );
  });
}
