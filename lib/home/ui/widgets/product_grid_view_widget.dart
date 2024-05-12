import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/home/domain/models/product_model.dart';
import 'package:stor_app/home/ui/home_cubit.dart';
import 'package:stor_app/home/ui/home_state.dart';
import 'package:stor_app/home/ui/widgets/product_item.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class ProductGridViewWidget extends StatelessWidget {
  const ProductGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.productsState is ProductsSuccess) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingDimensions.pagePadding),
            sliver: SliverGrid.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: PaddingDimensions.normal,
                mainAxisSpacing: PaddingDimensions.normal,
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  showProductBottomSheet(
                    state.productsState.productModelList?[index] ??
                        const ProductModel.initial(),
                    context,
                  );
                },
                child: ProductItemWidget(
                  model:
                  state.productsState.productModelList?[index] ??
                      const ProductModel.initial(),
                ),
              ),
              itemCount:
              state.productsState.productModelList?.length ?? 0,
            ),
          );
        } else if (state.productsState is ProductsError) {
          return SliverToBoxAdapter(
            child: Text(state.productsState.errorMessage ?? ''),
          );
        } else if (state.productsState is ProductsLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding:
                EdgeInsets.only(top: PaddingDimensions.xLarge.h),
                child: const CircularProgressIndicator(
                  color: AppColors.brown,
                ),
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter();
        }
      },
    );
  }
  void showProductBottomSheet(ProductModel model,BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.primary6,
          borderRadius:
          BorderRadiusDirectional.vertical(top: Radius.circular(12.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(PaddingDimensions.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Image.network(
                    model.image.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: PaddingDimensions.normal.h,
              ),
              Text(
                model.name,
                style: TextStyles.medium(
                  fontSize: Dimensions.large.sp,
                  color: AppColors.brown,
                  height: 1.3,
                ),
              ),
              SizedBox(
                height: PaddingDimensions.normal.h,
              ),
              Text(
                model.description,
                style: TextStyles.medium(
                  fontSize: Dimensions.large.sp,
                  color: AppColors.brown,
                ),
              ),
              const Row(children: []),
              //todo :add Counter
              SizedBox(
                height: PaddingDimensions.xxLarge.h,
              ),
              Text(
                "Price: ${model.price} \$",
                style: TextStyles.extraBold(
                  fontSize: Dimensions.large.sp,
                  color: AppColors.brown,
                ),
              ),
              const Spacer(),
              AppMaterialButton(
                buttonText: "Add to cart",
                onPressed: () {},
                isExpanded: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
