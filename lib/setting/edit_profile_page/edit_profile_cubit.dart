import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/auth/domain/usecases/update_user_data_use_case.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/common/utils/network_info.dart';
import 'package:stor_app/setting/edit_profile_page/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  late final UpdateUserDataUseCase _updateUserDataUseCase;
  late final CheckInternetConnectionUseCase _networkConnectionUseCase;

  EditProfileCubit() : super(EditProfileInitial()) {
    _loadUseCases();
  }

  void _loadUseCases() {
    _updateUserDataUseCase = injector();
    _networkConnectionUseCase = injector();
  }

  Future<void> updateUserData({required UserDataModel userData}) async {
    if (!await _networkConnectionUseCase.execute()) {
      emit(EditProfileFailure('No internet connection'));
    } else {
      emit(EditProfileLoading());
      try {
        await _updateUserDataUseCase.execute(userData: userData);
        emit(EditProfileSuccess());
      } on FirebaseException catch (e) {
        emit(EditProfileFailure(e.toString()));
      }
    }
  }
}
