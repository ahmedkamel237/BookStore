import 'package:bloc/bloc.dart';
import 'package:stor_app/admin/domain/usecases/get_all_categores_use_case.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _loadUseCases();
  }

  late final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  void _loadUseCases() {
    _getAllCategoriesUseCase = injector();
  }

  Future<void> getAllCategories() async {
    emit(HomeLoading());
    try {
      final categoryNames = await _getAllCategoriesUseCase.execute();
      emit(HomeSuccess(categoryNames: categoryNames));
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  @override
  void emit(HomeState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
