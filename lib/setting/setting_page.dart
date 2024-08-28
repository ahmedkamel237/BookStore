import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/auth/ui/login/login_page.dart';
import 'package:stor_app/packeges/app_materials/src/common_widget/failure_widget.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';
import 'package:stor_app/setting/edit_profile_page/edit_profile_page.dart';
import 'package:stor_app/setting/setting_cubit.dart';
import 'package:stor_app/setting/setting_state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getUserData(),
      child: const _SettingBody(),
    );
  }
}

class _SettingBody extends StatefulWidget {
  const _SettingBody();

  @override
  State<_SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<_SettingBody>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Setting',
          style: TextStyles.extraBold(
            fontSize: Dimensions.xLarge.sp,
            color: AppColors.brown,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.brown,
        backgroundColor: AppColors.primary7,
        onRefresh: () async {
          BlocProvider.of<SettingCubit>(context).getUserData();
        },
        child: BlocConsumer<SettingCubit, SettingState>(
          listener: (context, state) {
            if (state is LogoutSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            } else if (state is LogoutFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? ''),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GetUserDataSuccess) {
              return Padding(
                padding: const EdgeInsets.all(PaddingDimensions.large),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const _CustomSettingHiderWidget(title: "Account"),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightBrown,
                          border: Border.all(
                            color: AppColors.darkBrown,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(PaddingDimensions.normal),
                          child: Column(
                            children: [
                              _CustomSettingRow(
                                title: "Edit Profile",
                                icon: Icons.person,
                                onTap: () {
                                   final data = Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfilePage(
                                        user: state.userDataModel,
                                      ),
                                    ),
                                  );

                                  if (data != null) {
                                    setState(() {
                                      BlocProvider.of<SettingCubit>(context)
                                          .getUserData();
                                    });
                                  }
                                },
                              ),
                              _CustomSettingRow(
                                title: "Security",
                                icon: Icons.privacy_tip_rounded,
                                onTap: () {},
                              ),
                              _CustomSettingRow(
                                title: "Notifications",
                                icon: Icons.notifications,
                                onTap: () {},
                              ),
                              _CustomSettingRow(
                                title: "Privacy",
                                icon: Icons.lock,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: PaddingDimensions.large,
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<SettingCubit>(context).logout();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.logout,
                              color: AppColors.brown,
                              size: 30,
                            ),
                            SizedBox(
                              width: PaddingDimensions.large.w,
                            ),
                            Text(
                              "Logout",
                              style: TextStyles.semiBold(
                                color: AppColors.brown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is GetUserDataLoadingState ||
                state is LogoutLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.brown,
                ),
              );
            }
            if (state is GetUserDataFailure || state is LogoutFailureState) {
              return FailurePage(
                message: state.error,
                onPressed: () {
                  BlocProvider.of<SettingCubit>(context).getUserData();
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CustomSettingRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _CustomSettingRow(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PaddingDimensions.small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.semiBold(),
            ),
            Icon(
              icon,
              color: AppColors.brown,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSettingHiderWidget extends StatelessWidget {
  final String title;

  const _CustomSettingHiderWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.bold(
            fontSize: Dimensions.xLarge,
            color: AppColors.brown,
          ),
        ),
        SizedBox(height: PaddingDimensions.normal.h),
        const Divider(
          height: 5,
          thickness: 2,
          color: AppColors.darkBrown,
        ),
        SizedBox(height: PaddingDimensions.normal.h),
      ],
    );
  }
}
