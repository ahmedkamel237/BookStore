import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';
import 'package:stor_app/setting/edit_profile_page/edit_profile_cubit.dart';
import 'package:stor_app/setting/edit_profile_page/edit_profile_state.dart';

class EditProfilePage extends StatefulWidget {
  final UserDataModel user;
  final VoidCallback onUserDataUpdated;

  const EditProfilePage({
    super.key,
    required this.user,
    required this.onUserDataUpdated,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    super.initState();
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => EditProfileCubit(),
        child: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccess) {
              widget.onUserDataUpdated;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Your data has been updated"),
                ),
              );
              Navigator.of(context).pop();
            }
            if (state is EditProfileFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: AppColors.brown,
                title: Text(
                  'Edit Profile',
                  style: TextStyles.semiBold(
                    fontSize: Dimensions.xLarge,
                    color: AppColors.brown,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.large),
                child: Form(
                  key: _formKey,
                  onChanged: _isButtonEnabledPressed,
                  child: Column(
                    children: [
                      SizedBox(height: PaddingDimensions.xLarge.h),
                      AppTextFormField(
                        labelText: "First Name",
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          } else if (value.length < 2) {
                            return 'Please enter at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: PaddingDimensions.xLarge.h),
                      AppTextFormField(
                        labelText: "Last Name",
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          } else if (value.length < 2) {
                            return 'Please enter at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: PaddingDimensions.xLarge.h),
                      AppMaterialButton(
                        buttonText: 'Save',
                        onPressed: _isButtonEnabled
                            ? () {
                                _onButtonPressed(context);
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  void _isButtonEnabledPressed() {
    final isEmpty =
        _firstNameController.text.isEmpty || _lastNameController.text.isEmpty;
    final isUnchanged = widget.user.firstName == _firstNameController.text &&
        widget.user.lastName == _lastNameController.text;

    _isButtonEnabled = !(isEmpty || isUnchanged);

    setState(() {});
  }

  void _onButtonPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    final isValidate = _formKey.currentState?.validate() ?? false;
    if (isValidate) {
      BlocProvider.of<EditProfileCubit>(context).updateUserData(
        userData: UserDataModel(
          lastName: _lastNameController.text,
          firstName: _firstNameController.text,
          email: widget.user.email,
          id: widget.user.id,
        ),
      );
    }
  }
}
