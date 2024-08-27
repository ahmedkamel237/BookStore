import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/auth/ui/register/register_cubit.dart';
import 'package:stor_app/auth/ui/register/widget/register_form.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = 'RegisterPage';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => RegisterCubit(),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingDimensions.pagePadding,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: PaddingDimensions.xLarge.h),
                      Text(
                        'Sign Up',
                        style: TextStyles.extraBold(
                          color: AppColors.brown,
                          height: 1.3,
                          fontSize: Dimensions.xxLarge.sp,
                        ),
                      ),
                      SizedBox(height: PaddingDimensions.large.h),
                      Text(
                        'Create your new account\nto arrive in the best\nexperience.',
                        style: TextStyles.extraBold(
                          color: AppColors.darkBrown,
                          fontSize: Dimensions.xLarge.sp,
                          height: 1.4,
                        ),
                      ),
                      const RegisterForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
