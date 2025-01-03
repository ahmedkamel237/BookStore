import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/home/domain/models/product_model.dart';
import 'package:store_app/packeges/utils/material.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductModel model;

  const ProductItemWidget({super.key, required this.model});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isFavorite = false;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.vertical(top: (Radius.circular(8.r))),
                  ),
                  child: Image.network(
                    widget.model.image.first,
                    fit: BoxFit.cover,
                  ),
                ),
                Banner(
                  message: 'Sale',
                  layoutDirection: TextDirection.ltr,
                  textDirection: TextDirection.ltr,
                  location: BannerLocation.topStart,
                  color: Colors.yellow,
                  textStyle: TextStyles.extraBold(
                    fontSize: 12.sp,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : AppColors.black,
                              size: 18.r,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isAdded = !isAdded;
                              });
                            },
                            child: Icon(
                              size: 18.r,
                              isAdded ? Icons.shopping_cart : Icons.add_shopping_cart,
                              color: isAdded ? Colors.green : AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadiusDirectional.vertical(bottom: (Radius.circular(8.r))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  widget.model.name,
                  style: TextStyles.bold(
                    fontSize: 12.sp,
                    color: AppColors.brown,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '${widget.model.price}\$',
                style: TextStyles.bold(
                  fontSize: 14.sp,
                  color: AppColors.brown,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
