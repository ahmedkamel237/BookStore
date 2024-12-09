import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/packeges/utils/material.dart';
import 'package:store_app/packeges/utils/src/dimensions/padding_dimensions.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => Card(
          color: AppColors.primary6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120.h,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Text(
                      'Product ${index + 1}',
                      style: TextStyles.bold(
                        fontSize: Dimensions.large.sp,
                        color: AppColors.brown,
                      ),
                    ),
                    Text(
                      'Product ${index + 1}',
                      style: TextStyles.bold(
                        fontSize: Dimensions.large.sp,
                        color: AppColors.brown,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) =>
            SizedBox(height: PaddingDimensions.normal.h),
        itemCount: 10,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
