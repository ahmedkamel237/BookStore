import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/admin/ui/admin_page.dart';
import 'package:stor_app/home/ui/home_cubit.dart';
import 'package:stor_app/home/ui/home_state.dart';
import 'package:stor_app/home/ui/widgets/categories_item_widget.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllCategories(),
      child: const _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatefulWidget {
  const _HomePageBody();

  @override
  State<_HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Book Store',
          style: TextStyles.extraBold(
            fontSize: Dimensions.xLarge.sp,
            color: AppColors.brown,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<AdminAddedPage>(
                  builder: (context) => const AdminAddedPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_business_rounded,
              color: AppColors.brown,
            ),
          ),
          IconButton(
            onPressed: () async {},
            icon: const Icon(
              Icons.logout,
              color: AppColors.brown,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesSuccess) {
            {
              return RefreshIndicator(
                color: AppColors.brown,
                backgroundColor: AppColors.white,
                onRefresh: () async {
                  context.read<HomeCubit>().getAllCategories();
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics(),
                  ),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/store_app_background.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
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
                            itemBuilder: (context, index) => CategoriesItem(
                                model: state.categoryModelList[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: PaddingDimensions.normal,
                            ),
                            itemCount: state.categoryModelList.length,
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: PaddingDimensions.pagePadding),
                      sliver: SliverGrid.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: PaddingDimensions.normal,
                          mainAxisSpacing: PaddingDimensions.normal,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Image.asset(
                            'assets/store_app_background.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        itemCount: 10,
                      ),
                    ),
                    const SliverToBoxAdapter(
                        child: SizedBox(height: PaddingDimensions.normal,)),
                  ],
                ),
              );
            }
          } else if (state is CategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.brown,
              ),
            );
          } else if (state is CategoriesError) {
            return const Text("Home Error");
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
