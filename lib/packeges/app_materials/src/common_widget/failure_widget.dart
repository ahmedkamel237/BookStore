import 'package:flutter/material.dart';
import 'package:store_app/packeges/app_materials/material.dart';
import 'package:store_app/packeges/utils/material.dart';
import 'package:store_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class FailurePage extends StatelessWidget {
  final String? message;
  final VoidCallback onPressed;

  const FailurePage(
      {super.key, required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message ?? "No Internet Connection",
            style: TextStyles.bold(),
          ),
          const SizedBox(
            height: PaddingDimensions.xLarge,
          ),
          AppMaterialButton(
            buttonText: "Retry",
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
