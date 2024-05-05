abstract class AdminState {}

class AdminAddCategoryInitial extends AdminState {}

class AdminAddCategoryLoading extends AdminState {}

class AdminAddCategorySuccess extends AdminState {}

class AdminAddCategoryError extends AdminState {
  AdminAddCategoryError({required this.errorMessage});

  final String errorMessage;
}
