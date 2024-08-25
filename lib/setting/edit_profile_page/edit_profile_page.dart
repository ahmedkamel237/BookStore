import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class EditProfile extends StatefulWidget {
  final UserDataModel user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyles.semiBold(
            fontSize: Dimensions.xLarge,
            color: AppColors.brown,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: PaddingDimensions.xLarge.h),
               AppTextFormField(
                labelText: "First Name",
                controller: _firstNameController,
              ),
              SizedBox(height: PaddingDimensions.xLarge.h),
              AppTextFormField(
                labelText: "Last Name",
                controller: _lastNameController,
              ),
              SizedBox(height: PaddingDimensions.xLarge.h),
              AppMaterialButton(
                buttonText: 'Save',
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _validateButton() {

  }
  void _onButtonPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isButtonEnabled = true;
      });
    }
  }
}
