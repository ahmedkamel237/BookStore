import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/models/product_model.dart';

class HomeState {
  final ProductsState productsState;
  final CategoriesState categoriesState;

  HomeState(this.productsState, this.categoriesState);

  HomeState copyWith({
    ProductsState? productsState,
    CategoriesState? categoriesState,
    String? errorMessage,
  }) {
    return HomeState(
      productsState ?? this.productsState,
      categoriesState ?? this.categoriesState,
    );
  }

  HomeState.initial()
      : this(
          ProductsInitial(),
          CategoriesInitial(),
        );
}

abstract class CategoriesState {
  final List<CategoriesModel>? categoryModelList;
  final String? errorMessage;

  CategoriesState({
    this.categoryModelList,
    this.errorMessage,
  });
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  CategoriesSuccess({required super.categoryModelList});
}

class CategoriesError extends CategoriesState {
  CategoriesError({required super.errorMessage});
}

abstract class ProductsState {
  final List<ProductModel>? productModelList;
  final String? errorMessage;

  ProductsState({this.productModelList, this.errorMessage});
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  ProductsSuccess({required super.productModelList});
}

class ProductsError extends ProductsState {
  ProductsError({required super.errorMessage});
}
