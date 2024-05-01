import 'package:flutter/material.dart';
import 'package:stor_app/common/padding_values/padding_dimentions.dart';
import 'package:stor_app/common/themes/colors.dart';
import 'package:stor_app/common/themes/text_styles.dart';
import 'package:stor_app/common/widgets/app_text_form_filed.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/LoginPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PaddingDimentions.pagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyles.extraBold(
                textColor: AppColor.black,
                fontSize: Dimentions.xxxLarge,
              ),
            ),
            Form(
              onChanged: () {},
              child: const Column(
                children: [
                  SizedBox(height: PaddingDimentions.large),
                  AppTextFormField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
