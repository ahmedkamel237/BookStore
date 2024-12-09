import 'package:store_app/home/domain/models/categories_model.dart';
abstract class AdminState {
  final List<CategoriesModel>? categoryModelList;

  AdminState({ this.categoryModelList});
}

class AdminAddCategoryInitial extends AdminState {}

class AdminAddCategoryLoading extends AdminState {}

class AdminAddCategorySuccess extends AdminState {}

class AdminAddCategoryError extends AdminState {
  AdminAddCategoryError({required this.errorMessage});

  final String errorMessage;
}
class CategoriesInitial extends AdminState {}

class CategoriesLoading extends AdminState {}

class CategoriesSuccess extends AdminState {
  @override
  CategoriesSuccess({required super.categoryModelList});
}

class CategoriesError extends AdminState {
  CategoriesError({required this.errorMessage});


  final String errorMessage;
}

class RemoveCollectionInitial extends AdminState {}

class RemoveCollectionLoading extends AdminState {}

class RemoveCollectionSuccess extends AdminState {}

class RemoveCollectionError extends AdminState {
  RemoveCollectionError({required this.errorMessage});

  final String errorMessage;
}