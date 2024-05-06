import 'package:bloc/bloc.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/home/domain/use_cases/get_all_categores_use_case.dart';
import 'package:stor_app/home/ui/home_state.dart';

class HomeCubit extends Cubit<CategoriesState> {
  HomeCubit() : super(CategoriesInitial()) {
    _loadUseCases();
  }

  late final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  void _loadUseCases() {
    _getAllCategoriesUseCase = injector();
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

  @override
  void emit(CategoriesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
