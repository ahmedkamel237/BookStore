import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/auth/ui/login/login_cubit.dart';
import 'package:stor_app/auth/ui/login/widgets/login_form.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const routeName = '/LoginPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PaddingDimensions.pagePadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back to the\nBook Store!',
                style: TextStyles.extraBold(
                  textColor: AppColors.brown,
                  height: 1.3,
                  fontSize: Dimensions.xLarge.sp,
                ),
              ),
              SizedBox(height: PaddingDimensions.large.h),
              Text(
                'Login to your account',
                style: TextStyles.extraBold(
                  textColor: AppColors.darkBrown,
                  fontSize: Dimensions.medium.sp,
                ),
              ),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
