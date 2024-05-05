import 'package:bloc/bloc.dart';
import 'package:stor_app/admin/domain/usecases/add_categories_use_case.dart';
import 'package:stor_app/admin/ui/admin_state.dart';
import 'package:stor_app/common/base/app_injector.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminAddCategoryInitial()){
    _loadUseCase();
  }
  late final AddCategoriesUseCase _addCategoriesUseCase;
  void _loadUseCase() {
    _addCategoriesUseCase = injector();
  }


  Future<void> addCategories(String collectionName) async {
    emit(AdminAddCategoryLoading());
    try {
      await _addCategoriesUseCase.execute(collectionName);
      emit(AdminAddCategorySuccess());
    } catch (e) {
      emit(AdminAddCategoryError(errorMessage: e.toString()));
    }
  }
}
