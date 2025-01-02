import 'package:bloc/bloc.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/base/async.dart';
import 'package:store_app/home/domain/use_cases/get_all_categores_use_case.dart';
import 'package:store_app/home/domain/use_cases/get_all_product_use_case.dart';
import 'package:store_app/home/ui/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getAllCategoriesUseCase,this._getAllProductUseCase,)
      : super(
    HomeState.initial(),
  ) {
    // _loadUseCases();
  }

  late final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  late final GetAllProductUseCase _getAllProductUseCase;

  void _loadUseCases() {
    _getAllCategoriesUseCase = injector();
    _getAllProductUseCase = injector();
  }

  Future<void> getAllCategories() async {
    emit(state.copyWith(getAllCategory: Async.loading()));
    try {
      final data = await _getAllCategoriesUseCase.execute();
      emit(state.copyWith(getAllCategory: Async.success(data)));
    } catch (e) {
      emit(
        state.copyWith(
          getAllCategory: Async.failure(
            Failure(
              message: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  Future<void> getAllProducts(String categoryId) async {
    emit(state.copyWith(getAllProduct: Async.loading()));
    try {
      final data = await _getAllProductUseCase.execute(categoryId);
      emit(state.copyWith(getAllProduct: Async.success(data)));
    } catch (e) {
      emit(
        state.copyWith(
          getAllProduct: Async.failure(
            Failure(
              message: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  @override
  void emit(HomeState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
