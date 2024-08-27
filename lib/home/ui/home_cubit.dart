import 'package:bloc/bloc.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/home/domain/use_cases/get_all_categores_use_case.dart';
import 'package:stor_app/home/domain/use_cases/get_all_product_use_case.dart';
import 'package:stor_app/home/ui/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    _loadUseCases();
  }

  late final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  late final GetAllProductUseCase _getAllProductUseCase;

  void _loadUseCases() {
    _getAllCategoriesUseCase = injector();
    _getAllProductUseCase = injector();
  }

  Future<void> getAllCategories() async {
    emit(state.copyWith(categoriesState: CategoriesLoading()));
    try {
      final data = await _getAllCategoriesUseCase.execute();
      emit(state.copyWith(categoriesState: CategoriesSuccess(categoryModelList: data)));
    } catch (e) {
      emit(state.copyWith(categoriesState: CategoriesError(errorMessage: e.toString())));
    }
  }

  Future<void> getAllProducts(String categoryId) async {
    emit(state.copyWith(productsState: ProductsLoading()));
    try {
      final data = await _getAllProductUseCase.execute(categoryId);
      emit(state.copyWith(productsState: ProductsSuccess(productModelList: data)));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  @override
  void emit(HomeState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
