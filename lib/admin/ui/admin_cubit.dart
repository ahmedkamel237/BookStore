import 'package:bloc/bloc.dart';
import 'package:store_app/admin/domain/usecases/add_categories_use_case.dart';
import 'package:store_app/admin/domain/usecases/remove_collection.dart';
import 'package:store_app/admin/ui/admin_state.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/home/domain/models/categoriey_model_input.dart';
import 'package:store_app/home/domain/use_cases/get_all_categores_use_case.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminAddCategoryInitial()) {
    _loadUseCase();
  }

  late final AddCategoriesUseCase _addCategoriesUseCase;
  late final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  late final RemoveCollectionUseCase _removeCollectionUseCase;

  void _loadUseCase() {
    _addCategoriesUseCase = injector();
    _getAllCategoriesUseCase = injector();
    _removeCollectionUseCase = injector();
  }

  Future<void> addCategories(CategoriesModelInput input) async {
    emit(AdminAddCategoryLoading());
    try {
      await _addCategoriesUseCase.execute(input);
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

  deleteCollection(String id) async {
    emit(RemoveCollectionLoading());
    try {
    await _removeCollectionUseCase.execute(id);
    emit(RemoveCollectionSuccess());
    } catch (e) {
      emit(RemoveCollectionError(errorMessage: e.toString()));
    }
  }

  @override
  void emit(AdminState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
