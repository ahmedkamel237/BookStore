import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PaddingDimensions.pagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back to the\nBook Store!',
              style: TextStyles.extraBold(
                textColor: AppColor.brown,
                height: 1.3,
                fontSize: Dimensions.xLarge.sp,
              ),
            ),
            SizedBox(height: PaddingDimensions.large.h),
            Text(
              'Login to your account',
              style: TextStyles.extraBold(
                textColor: AppColor.darkBrown,
                fontSize: Dimensions.medium.sp,
              ),
            ),
            Form(
              key: _formKey,
              onChanged: () {
                _formKey.currentState?.validate();
                setState(() {});
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: PaddingDimensions.large.h),
                  const AppTextFormField(
                    hintText: 'example@gmail.com',
                    labelText: 'Email',
                  ),
                  SizedBox(height: PaddingDimensions.large.h),
                   AppTextFormField(
                    hintText: '**********',
                    labelText: 'Password',
                    obscureText: _obscureText,
                  ),
                  SizedBox(height: PaddingDimensions.normal.h),
                  Text(
                    'Forget password?',
                    style: TextStyles.bold(
                      fontSize: Dimensions.medium.sp,
                      textColor: AppColor.brown,
                    ),
                  ),
                  SizedBox(height: PaddingDimensions.large.h),
                  SizedBox(
                    width: double.infinity,
                    child: AppMaterialButton(
                      onPressed: () {},
                      buttonText: 'Login',
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
}
