import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/auth/ui/forget_password/forget_password_cubit.dart';
import 'package:store_app/auth/ui/forget_password/forget_password_state.dart';
import 'package:store_app/common/helpers/helpers/app_regx.dart';
import 'package:store_app/packeges/app_materials/material.dart';
import 'package:store_app/packeges/utils/material.dart';
import 'package:store_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => ForgetPasswordCubit(),
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccess) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Password Reset Successfully')));
              }
              if (state is ForgetPasswordFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error ?? '')));
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  foregroundColor: AppColors.brown,
                ),
                body: Form(
                  key: _formKey,
                  onChanged: _isButtonEnabledPressed,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PaddingDimensions.pagePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reset Password',
                          style: TextStyles.extraBold(
                            color: AppColors.brown,
                            height: 1.3,
                            fontSize: Dimensions.xxLarge.sp,
                          ),
                        ),
                        SizedBox(height: PaddingDimensions.large.h),
                        Text(
                          'Enter your email address to reset your password.',
                          style: TextStyles.extraBold(
                            color: AppColors.darkBrown,
                            fontSize: Dimensions.xLarge.sp,
                          ),
                        ),
                        const SizedBox(height: PaddingDimensions.large),
                        AppTextFormField(
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          hintText: 'example@gmail.com',
                          labelText: 'Email',
                          controller: _emailController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !AppRegex.isEmailValid(value)) {
                              return "please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: PaddingDimensions.large),
                        if (state is ForgetPasswordLoading)
                          const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.brown,
                            ),
                          )
                        else
                          AppMaterialButton(
                            buttonText: "Send",
                            isExpanded: true,
                            onPressed:
                                _isButtonEnabled ? (){
                                  _forgetPasswordFun(context);
                                } : null,
                          ),
                        const SizedBox(height: PaddingDimensions.large),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _forgetPasswordFun(BuildContext context) {
    FocusScope.of(context).unfocus();
    final isValidate = _formKey.currentState?.validate() ?? false;
    if (isValidate) {
      BlocProvider.of<ForgetPasswordCubit>(context).resetPassword(
          email: _emailController.text,
      );
    }
  }

  void _isButtonEnabledPressed() {
    if (_emailController.text.isEmpty) {
      _isButtonEnabled = false;
      setState(() {});
    } else {
      _isButtonEnabled = true;
      setState(() {});
    }
    setState(() {});
  }
}
