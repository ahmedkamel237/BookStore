import 'package:bloc/bloc.dart';
import 'package:stor_app/admin/domain/usecases/add_categories_use_case.dart';
import 'package:stor_app/admin/ui/admin_state.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/home/domain/models/categories_model.dart';
import 'package:stor_app/home/domain/use_cases/get_all_categores_use_case.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminAddCategoryInitial()){
    _loadUseCase();
  }
  late final AddCategoriesUseCase _addCategoriesUseCase;
  late final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  void _loadUseCase() {
    _addCategoriesUseCase = injector();
    _getAllCategoriesUseCase = injector();
  }


  Future<void> addCategories(CategoriesModel model) async {
    emit(AdminAddCategoryLoading());
    try {
      await _addCategoriesUseCase.execute(model);
      emit(AdminAddCategorySuccess());
    } catch (e) {
      emit(AdminAddCategoryError(errorMessage: e.toString()));
    }
  }
  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    try {
      final data = await _getAllCategoriesUseCase.execute();
      emit(CategoriesSuccess(categoryModelList: data));
    } catch (e) {
      emit(CategoriesError(errorMessage: e.toString()));
    }
  }
}
