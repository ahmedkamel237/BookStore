import 'package:flutter/material.dart';
import 'package:stor_app/home/domain/models/categories_model.dart';
import 'package:stor_app/packeges/utils/material.dart';
import 'package:stor_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class CategoriesItem extends StatelessWidget {
  final CategoriesModel model;
  const CategoriesItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Column(
        children: [
          Container(
            height:
            MediaQuery.sizeOf(context).height * 0.1 -
                PaddingDimensions.normal,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.brown,
              ),
            ),
            width: MediaQuery.sizeOf(context).height * 0.1 -
                PaddingDimensions.normal,
            child: Image.asset(
              'assets/store_app_background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Text(model.name),
        ],
      ),
    );
  }
}
