import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/ui/home_cubit.dart';
import 'package:store_app/home/ui/home_state.dart';
import 'package:store_app/home/ui/widgets/categories_item_widget.dart';
import 'package:store_app/packeges/utils/material.dart';
import 'package:store_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.getAllCategory?.isSuccess==true) {
          return SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _SliverAppBarDelegate(
              minHeight: MediaQuery.sizeOf(context).height * 0.17.h,
              maxHeight: MediaQuery.sizeOf(context).height * 0.17.h,
              child: Container(
                color: AppColors.primary8,
                height: MediaQuery.sizeOf(context).height * 0.17.h,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: PaddingDimensions.pagePadding,
                    vertical: PaddingDimensions.pagePadding,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      context.read<HomeCubit>().getAllProducts(state
                          .getAllCategory
                          ?.data?[index]
                          .id ??
                          '');
                    },
                    child: CategoriesItem(
                      model: state.getAllCategory
                          ?.data?[index] ??
                          const CategoriesModel.initial(),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                  const SizedBox(
                    width: PaddingDimensions.normal,
                  ),
                  itemCount: state.getAllCategory?.data
                      ?.length ??
                      0,
                ),
              ),
            ),
          );
        } else if (state.getAllCategory?.isSuccess==true) {
          return SliverToBoxAdapter(
            child: Text(state.getAllCategory?.failure?.message ?? ''),
          );
        }
        else if (state.getAllCategory?.isLoading ==true) {
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
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
