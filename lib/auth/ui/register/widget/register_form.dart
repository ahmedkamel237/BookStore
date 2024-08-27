import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/auth/domain/models/register_model_input.dart';
import 'package:stor_app/auth/ui/login/login_page.dart';
import 'package:stor_app/auth/ui/register/register_cubit.dart';
import 'package:stor_app/auth/ui/register/register_state.dart';
import 'package:stor_app/builder_screen.dart';
import 'package:stor_app/common/helpers/helpers/app_regx.dart';
import 'package:stor_app/packeges/app_materials/material.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final bool _obscureText = true;
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _isButtonEnabledPressed,
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Register Successfully")),
            );
            Navigator.of(context).pushReplacementNamed(BuilderScreen.routeName);
          } else if (state is RegisterFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? '')),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppTextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      hintText: 'Ahmed',
                      labelText: 'First Name',
                      controller: _firstNameController,
                      maxErrorLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter first name";
                        } else if (value.length < 2) {
                          return "please enter at least 2 character";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: PaddingDimensions.large.w,
                  ),
                  Expanded(
                    child: AppTextFormField(
                      maxErrorLines: 2,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Last Name',
                      hintText: 'mahmoud',
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter last name";
                        } else if (value.length < 2) {
                          return "please enter at least 2 character";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
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
                  } else if (_passwordController.text.length < 8) {
                    return "password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: PaddingDimensions.large.h),
              AppTextFormField(
                hintText: '**********',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: 'Confirm Password',
                obscureText: _obscureText,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    return "passwords don't match";
                  } else if (_passwordController.text.length < 8) {
                    return "password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: PaddingDimensions.large.h),
              if (state is RegisterLoadingState)
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.brown,
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: AppMaterialButton(
                    onPressed: _isButtonEnabled ? _registerFun : null,
                    buttonText: 'Register',
                  ),
                ),
              SizedBox(height: PaddingDimensions.large.h),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyles.bold(
                          fontSize: Dimensions.large.sp,
                          color: AppColors.brown,
                        ),
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Login',
                              style: TextStyles.extraBold(
                                fontSize: Dimensions.large.sp,
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
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _passwordController.text != _confirmPasswordController.text ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty &&
        _formKey.currentState!.validate()) {
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

  void _registerFun() {
    FocusScope.of(context).unfocus();
    final isValidate = _formKey.currentState?.validate() ?? false;
    if (isValidate) {
      BlocProvider.of<RegisterCubit>(context).register(
        registerModelInput: UserRegisterModelInput(
          email: _emailController.text,
          password: _passwordController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
        ),
      );
    }
  }
}
