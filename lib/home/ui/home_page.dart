import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/admin/ui/admin_page.dart';
import 'package:stor_app/home/ui/home_cubit.dart';
import 'package:stor_app/home/ui/home_state.dart';
import 'package:stor_app/home/ui/widgets/category_list_widget.dart';
import 'package:stor_app/home/ui/widgets/product_grid_view_widget.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
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
  String? initialCategoryId;

  @override
  void initState() {
    context.read<HomeCubit>().getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
      body: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            previous.categoriesState != current.categoriesState,
        listener: (context, state) {
          if (state.categoriesState is CategoriesSuccess) {
            initialCategoryId =
                state.categoriesState.categoryModelList?.first.id;
            context.read<HomeCubit>().getAllProducts(initialCategoryId ?? '');
          }
        },
        child: RefreshIndicator(
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
              const CategoryListWidget(),
              const ProductGridViewWidget(),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: PaddingDimensions.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
