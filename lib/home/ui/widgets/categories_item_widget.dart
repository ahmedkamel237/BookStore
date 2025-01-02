import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/packeges/utils/material.dart';
import 'package:store_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class CategoriesItem extends StatelessWidget {
  final CategoriesModel model;

  const CategoriesItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).height * 0.1 - PaddingDimensions.normal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.1 -
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
              model.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: PaddingDimensions.normal),
          Text(
            model.name,
            textAlign: TextAlign.center,
            style: TextStyles.regular(
              fontSize: Dimensions.medium.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
