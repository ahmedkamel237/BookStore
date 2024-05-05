import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/admin/ui/admin_cubit.dart';
import 'package:stor_app/admin/ui/admin_state.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class AdminAddedPage extends StatelessWidget {
  const AdminAddedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: const _AdminAddedBody(),
    );
  }
}

class _AdminAddedBody extends StatefulWidget {
  const _AdminAddedBody();

  @override
  State<_AdminAddedBody> createState() => _AdminAddedBodyState();
}

class _AdminAddedBodyState extends State<_AdminAddedBody> {
  final TextEditingController _collectionController = TextEditingController();
  bool _isEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _collectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminAddCategorySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Collection Added Successfully")),
            );
            Navigator.of(context).pop();
          } else if (state is AdminAddCategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingDimensions.pagePadding,
            ),
            child: Form(
              key: _formKey,
              onChanged: _isButtonEnabledPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add New Collection",
                    style: TextStyles.bold(
                      fontSize: Dimensions.large.sp,
                    ),
                  ),
                  SizedBox(height: PaddingDimensions.large.h),
                  AppTextFormField(
                    hintText: 'Collection Name',
                    controller: _collectionController,
                  ),
                  SizedBox(height: PaddingDimensions.large.h),
                  Center(
                    child: state is AdminAddCategoryLoading
                        ? const CircularProgressIndicator(
                            color: AppColors.brown,
                          )
                        : AppMaterialButton(
                            buttonText: 'Add',
                            onPressed: _isEnabled ? _addCollection : null,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _isButtonEnabledPressed() {
    if (_collectionController.text.isEmpty) {
      _isEnabled = false;
      setState(() {});
    } else {
      _isEnabled = true;
      setState(() {});
    }
    setState(() {});
  }

  void _addCollection() {
    FocusManager.instance.primaryFocus?.unfocus();
    final isValidate = _formKey.currentState?.validate() ?? false;
    if (isValidate) {
      BlocProvider.of<AdminCubit>(context).addCategories(
        _collectionController.text,
      );
    }
  }
}
