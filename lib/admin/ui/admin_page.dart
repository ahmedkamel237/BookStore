import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/admin/ui/admin_cubit.dart';
import 'package:stor_app/admin/ui/admin_state.dart';
import 'package:stor_app/home/domain/models/categories_model.dart';
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
                  SizedBox(height: PaddingDimensions.large.h),
                  Text(
                    "All Collections",
                    style: TextStyles.bold(
                      fontSize: Dimensions.large.sp,
                    ),
                  ),
                  SizedBox(height: PaddingDimensions.large.h),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        children: [
                          Text(
                            state.categoryModelList?[index].name ?? '',
                            style: TextStyles.regular(
                              fontSize: Dimensions.large.sp,
                            ),
                          ),
                          const Spacer(),
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
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    AppMaterialButton(
                                      buttonText: "Yes",
                                      onPressed: () {
                                        BlocProvider.of<AdminCubit>(context)
                                            .deleteCollection(
                                          state.categoryModelList?[index].id ?? '',
                                        );
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    AppMaterialButton(
                                        buttonText: "No",
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
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
        CategoriesModel(
          name: _collectionController.text,
          image: 'assets/store_app_background.jpeg',
          id: '',
        ),
      );
    }
  }
}
