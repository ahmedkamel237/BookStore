import 'package:equatable/equatable.dart';
import 'package:store_app/common/base/async.dart';
import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/models/product_model.dart';

class HomeState extends Equatable {
  final Async<List<CategoriesModel>>? getAllCategory;
  final Async<List<ProductModel>>? getAllProduct;
  final String? errorMessage;

  const HomeState({
    this.getAllCategory,
    this.getAllProduct,
    this.errorMessage,
  });

  HomeState copyWith({
    Async<List<CategoriesModel>>? getAllCategory,
    Async<List<ProductModel>>? getAllProduct,
    String? errorMessage,
  }) {
    return HomeState(
      getAllCategory: getAllCategory ?? this.getAllCategory,
      getAllProduct: getAllProduct ?? this.getAllProduct,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  HomeState.initial()
      : this(
          getAllCategory: Async.initial(),
          getAllProduct: Async.initial(),
          errorMessage: null,
        );

  @override
  List<Object?> get props => [getAllCategory, getAllProduct, errorMessage];
}
