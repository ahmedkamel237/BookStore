import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: const Text(
          'Book Store',
          style: TextStyle(
            color: AppColors.brown,
            fontWeight: FontWeight.bold,
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
            onPressed: () async {
              // showDialog(
              //   context: context,
              //   builder: (context) => Column(),
              // );
            },
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
                onRefresh: () async {
                  context.read<HomeCubit>().getAllCategories();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/store_app_background.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: PaddingDimensions.normal),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.12,
                        child: ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: PaddingDimensions.pagePadding,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CategoriesItem(model: state.categoryModelList[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: PaddingDimensions.normal,
                          ),
                          itemCount: state.categoryModelList.length,
                        ),
                      ),
                    ],
                  ),
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