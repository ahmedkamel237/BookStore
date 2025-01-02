import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:store_app/core/utils/theme/utils/theme_mapper.dart';

class ThemeCubit extends HydratedCubit<AppTheme> {
  ThemeCubit() : super(themeMapper[ThemeNames.green]!);

  void updateTheme(AppTheme newTheme) {
    emit(newTheme);
  }

  final String _jsonKey = 'themeMode';

  @override
  AppTheme fromJson(Map<String, dynamic> json) {
    final savedTheme = json[_jsonKey];
    return  AppTheme.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppTheme state) {
    return state.toMap();
  }
}
