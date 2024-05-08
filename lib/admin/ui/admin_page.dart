import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stor_app/admin/ui/admin_cubit.dart';
import 'package:stor_app/admin/ui/admin_state.dart';
import 'package:stor_app/home/domain/models/categoriey_model_input.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class AdminAddedPage extends StatelessWidget {
  const AdminAddedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..getAllCategories(),
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
  XFile? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _collectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Collections",
          style: TextStyles.bold(
            fontSize: Dimensions.large.sp,
          ),
        ),
      ),
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
                  SizedBox(height: PaddingDimensions.large.h),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFormField(
                          hintText: 'Collection Name',
                          controller: _collectionController,
                        ),
                      ),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        minWidth: 35.w,
                        onPressed: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            _image = XFile(image.path);
                          }
                          setState(() {});
                        },
                        child: Icon(
                          Icons.add_photo_alternate_rounded,
                          size: 30.sp,
                          color: AppColors.brown,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: PaddingDimensions.large.h),
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: AppColors.primary6,
                        border: Border.all(
                          color: AppColors.brown,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: _image == null
                            ? const Text('No image selected.')
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Image.file(
                                  File(
                                    _image?.path ?? '',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
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
                  if (state.categoryModelList?.isNotEmpty == true) ...[
                    Text(
                      "All Collections",
                      style: TextStyles.bold(
                        fontSize: Dimensions.large.sp,
                      ),
                    ),
                    SizedBox(height: PaddingDimensions.large.h),
                    state is CategoriesLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.brown,
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                children: [
                                  Text(
                                    state.categoryModelList?[index].name ?? '',
                                    style: TextStyles.regular(
                                      fontSize: Dimensions.large.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  const InkWell(
                                    child: Icon(
                                      size: 18,
                                      Icons.edit,
                                      color: AppColors.brown,
                                    ),
                                  ),
                                  SizedBox(width: PaddingDimensions.normal.w),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          backgroundColor: AppColors.primary4,
                                          title: Text(
                                            "Are you sure you want to delete this collection?",
                                            textAlign: TextAlign.center,
                                            style: TextStyles.regular(
                                              height: 1.4,
                                              color: AppColors.primary8,
                                              fontSize: Dimensions.xLarge.sp,
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            AppMaterialButton(
                                              buttonText: "Yes",
                                              onPressed: () {
                                                BlocProvider.of<AdminCubit>(
                                                        context)
                                                    .deleteCollection(
                                                  state
                                                          .categoryModelList?[
                                                              index]
                                                          .id ??
                                                      '',
                                                );
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            AppMaterialButton(
                                              buttonText: "No",
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: AppColors.brown,
                                    ),
                                  ),
                                ],
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15.w),
                              itemCount: state.categoryModelList?.length ?? 0,
                            ),
                          ),
                    SizedBox(height: PaddingDimensions.large.h),
                  ],
                  SizedBox(height: PaddingDimensions.large.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _isButtonEnabledPressed() {
    if (_collectionController.text.isEmpty || _image == null) {
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
        CategoriesModelInput(
          image: _image?.path ?? '',
          name: _collectionController.text,
        ),
      );
    }
  }
}
