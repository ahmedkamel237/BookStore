import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/home/domain/models/product_model.dart';
import 'package:store_app/home/ui/home_cubit.dart';
import 'package:store_app/home/ui/home_state.dart';
import 'package:store_app/home/ui/widgets/product_item.dart';
import 'package:store_app/packeges/app_materials/material.dart';
import 'package:store_app/packeges/utils/material.dart';
import 'package:store_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class ProductGridViewWidget extends StatelessWidget {
  const ProductGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.getAllProduct?.isSuccess == true) {
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
                    state.getAllProduct?.data?[index] ??
                        const ProductModel.initial(),
                    context,
                  );
                },
                child: ProductItemWidget(
                  model:
                  state.getAllProduct?.data?[index] ??
                      const ProductModel.initial(),
                ),
              ),
              itemCount:
              state.getAllProduct?.data?.length ?? 0,
            ),
          );
        } else if (state.getAllProduct?.isFailure == true) {
          return SliverToBoxAdapter(
            child: Text(state.getAllProduct?.failure?.message ?? ''),
          );
        } else if (state.getAllProduct?.isLoading==true) {
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 30,
                    shadowColor: AppColors.brown,
                    child: Image.network(
                      model.image.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: PaddingDimensions.normal.h,
              ),
              Text(
                model.name,
                style: TextStyles.extraBold(
                  fontSize: Dimensions.large.sp,
                  color: AppColors.black,
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
                  color: AppColors.black,
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
