
import 'package:stor_app/home/domain/models/categories_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  CategoriesSuccess({required this.categoryModelList});

  final List<CategoriesModel> categoryModelList;
}

class CategoriesError extends CategoriesState {
  CategoriesError({required this.errorMessage});


  final String errorMessage;
}
