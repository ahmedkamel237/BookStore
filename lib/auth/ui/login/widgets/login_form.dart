import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/ui/login/login_cubit.dart';
import 'package:stor_app/auth/ui/login/login_state.dart';
import 'package:stor_app/builder_screen.dart';
import 'package:stor_app/common/helpers/helpers/app_regx.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _obscureText = true;
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _isButtonEnabledPressed,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successfully")),
            );
            Navigator.of(context).pushReplacementNamed(BuilderScreen.routeName);
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: PaddingDimensions.large.h),
              AppTextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
              SizedBox(height: PaddingDimensions.large.h),
              AppTextFormField(
                hintText: '**********',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: 'Password',
                obscureText: _obscureText,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: PaddingDimensions.normal.h),
              Text(
                'Forget password?',
                style: TextStyles.bold(
                  fontSize: Dimensions.medium.sp,
                  textColor: AppColors.brown,
                ),
              ),
              SizedBox(height: PaddingDimensions.large.h),
              if (state is LoginLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.brown,
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: AppMaterialButton(
                    onPressed: _isButtonEnabled ? _loginFun : null,
                    buttonText: 'Login',
                  ),
                ),
              SizedBox(height: PaddingDimensions.large.h),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyles.bold(
                          fontSize: Dimensions.medium.sp,
                          textColor: AppColors.brown,
                        ),
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {},
                          child: RichText(
                            text: TextSpan(
                              text: 'Sign up',
                              style: TextStyles.extraBold(
                                fontSize: Dimensions.medium.sp,
                                color: AppColors.brown,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _isButtonEnabledPressed() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _isButtonEnabled = false;
      setState(() {});
    } else {
      _isButtonEnabled = true;
      setState(() {});
    }
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginFun() {
    FocusScope.of(context).unfocus();
    final isValidate = _formKey.currentState?.validate() ?? false;
    if (isValidate) {
      BlocProvider.of<LoginCubit>(context).login(
        loginInputModel: LoginInputModel(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
